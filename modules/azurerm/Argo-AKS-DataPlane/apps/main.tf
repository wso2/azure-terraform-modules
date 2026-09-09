# -------------------------------------------------------------------------------------
#
# Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------
#
# Raw kubernetes/helm resources, no dependency on wso2/common-terraform-modules.
#
# --------------------------------------------------------------------------------------

resource "kubernetes_namespace_v1" "this" {
  for_each = toset(concat(var.namespaces, [var.argocd_namespace, var.system_namespace]))

  metadata {
    name = each.value
  }
}

# ONE shared argo-server + workflow-controller per data plane, in
# system_namespace - matches the security review doc's data-plane diagram
# ("system-pool - shared ... argo-server (argo-CLOUD-stage / -prod)") and
# its explicit statement that "the workflow-controller and Argo Events
# controllers see every namespace on their cluster - this is normal
# Kubernetes control-plane behaviour." Tier isolation is real RBAC
# (data-plane-tier-rbac.yaml / data-plane-debug-access-rbac.yaml, applied
# via manifest_files), not separate controller instances per tier.
resource "helm_release" "argo_workflows" {
  name             = "argo-workflows"
  repository       = var.argo_helm_repo
  chart            = "argo-workflows"
  version          = var.argo_workflows_chart_version
  namespace        = var.system_namespace
  create_namespace = false
  values           = var.argo_workflows_values

  depends_on = [kubernetes_namespace_v1.this]
}

resource "helm_release" "argo_events" {
  name             = "argo-events"
  repository       = var.argo_helm_repo
  chart            = "argo-events"
  version          = var.argo_events_chart_version
  namespace        = var.system_namespace
  create_namespace = false
  values           = var.argo_events_values

  depends_on = [kubernetes_namespace_v1.this]
}

resource "helm_release" "argocd" {
  count = var.install_argocd ? 1 : 0

  name             = "argocd"
  repository       = var.argocd_helm_repo
  chart            = "argo-cd"
  version          = var.argocd_chart_version
  namespace        = var.argocd_namespace
  create_namespace = false
  values           = var.argocd_values

  depends_on = [kubernetes_namespace_v1.this]
}

# --- External Secrets Operator - syncs this data plane's IS-deploy tier
#     secrets from Azure Key Vault. Unlike the AWS apps modules, ESO's own
#     controller pod needs no identity annotation here - the
#     ClusterSecretStore it applies below authenticates via
#     serviceAccountRef, pointing at one of the federated ServiceAccounts
#     created below instead. ---

resource "kubernetes_namespace_v1" "external_secrets" {
  count = var.install_external_secrets ? 1 : 0

  metadata {
    name = var.eso_namespace
  }
}

resource "helm_release" "external_secrets" {
  count = var.install_external_secrets ? 1 : 0

  name             = "external-secrets"
  repository       = var.eso_helm_repo
  chart            = "external-secrets"
  version          = var.eso_chart_version
  namespace        = var.eso_namespace
  create_namespace = false

  depends_on = [kubernetes_namespace_v1.external_secrets]
}

# ServiceAccounts a ClusterSecretStore's serviceAccountRef (or any other
# Workload-Identity-authenticated workload) authenticates as - each
# annotated with the client_id of a cluster module deploy_identities
# entry, trusted via this cluster's own AKS OIDC issuer for exactly that
# (namespace, name) subject. Real example: asgardeo-is-deploy-sa in the
# system_namespace, consumed by azure-kv-store's ClusterSecretStore.
resource "kubernetes_service_account_v1" "federated" {
  for_each = var.federated_service_accounts

  metadata {
    name      = each.key
    namespace = each.value.namespace
    annotations = {
      "azure.workload.identity/client-id" = each.value.client_id
    }
    labels = {
      "azure.workload.identity/use" = "true"
    }
  }

  depends_on = [kubernetes_namespace_v1.this]
}

# Several real pipeline manifests are multi-document YAML (Deployment +
# Service + IngressRoute in one file, multiple RBAC objects, etc.) - split
# on a bare "---" line first, same as kubectl_manifest_documents below.
#
# kubectl_manifest (not kubernetes_manifest) here too, not just for the
# CRD-backed entries below - same silent-client-construction-failure bug
# control-plane's main.tf documents ("kubernetes_manifest's silent
# token-drop bug with static tokens"): kubernetes_manifest builds its own
# REST client independently of the rest of the provider, and that path
# doesn't reliably work with exec-based auth (kubelogin here, aws eks
# get-token on control-plane) - every instance failed with "cannot create
# REST client: no client config" on a real apply, regardless of
# parallelism. kubectl_manifest takes raw YAML text directly, so no
# yamldecode() round-trip is needed either.
locals {
  manifest_documents = flatten([
    for idx, m in var.manifest_files : [
      for doc_idx, doc in [
        for chunk in split("\n---\n", "\n${m.content != null ? m.content : templatefile(m.location, m.template_map)}") : chunk
        if trimspace(chunk) != ""
        ] : {
        key  = "${idx}-${doc_idx}"
        body = doc
      }
    ]
  ])
}

resource "kubectl_manifest" "this" {
  for_each = { for d in local.manifest_documents : d.key => d.body }

  yaml_body = each.value

  # wait_for_rollout defaults to true for Deployment/DaemonSet/StatefulSet
  # kinds (a no-op for everything else here) - tunnel-client's Deployment
  # needs a Secret (tunnel-client-key) that's only created once this
  # entire module finishes applying, so waiting here deadlocks: Terraform
  # blocks inside this apply for a pod that can't start until after this
  # apply is done. Kubernetes' own reconciliation starts the pod for real
  # moments later regardless of whether Terraform waited around for it.
  wait_for_rollout = false

  depends_on = [helm_release.argo_workflows, helm_release.argo_events, helm_release.argocd]
}

# CRD-backed manifests (ESO's ClusterSecretStore/ExternalSecret) applied in
# the same run that installs their CRDs - see the AWS apps modules'
# identical mechanism for why kubectl_manifest, not kubernetes_manifest,
# is required here.
locals {
  kubectl_manifest_documents = flatten([
    for idx, m in var.kubectl_manifest_files : [
      for doc_idx, doc in [
        for chunk in split("\n---\n", "\n${m.content != null ? m.content : templatefile(m.location, m.template_map)}") : chunk
        if trimspace(chunk) != ""
        ] : {
        key  = "${idx}-${doc_idx}"
        body = doc
      }
    ]
  ])
}

resource "kubectl_manifest" "extra" {
  for_each = { for d in local.kubectl_manifest_documents : d.key => d.body }

  yaml_body = each.value

  # See kubectl_manifest.this's identical comment on wait_for_rollout.
  wait_for_rollout = false

  depends_on = [helm_release.external_secrets, kubernetes_service_account_v1.federated, helm_release.argo_workflows, helm_release.argo_events, helm_release.argocd]
}
