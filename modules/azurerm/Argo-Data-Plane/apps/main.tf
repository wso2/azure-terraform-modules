# -------------------------------------------------------------------------------------
#
# Copyright (c) 2026, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
#
# WSO2 LLC. licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the
# specific language governing permissions and limitations
# under the License.
#
# --------------------------------------------------------------------------------------

resource "kubernetes_namespace_v1" "namespace" {
  for_each = toset(concat(var.namespaces, [var.argocd_namespace, var.system_namespace]))

  metadata {
    name = each.value
  }
}

# One shared controller per data plane; tiers are isolated by RBAC, not separate installs.
resource "helm_release" "argo_workflows" {
  name             = "argo-workflows"
  repository       = var.argo_helm_repo
  chart            = "argo-workflows"
  version          = var.argo_workflows_chart_version
  namespace        = var.system_namespace
  create_namespace = false
  values           = var.argo_workflows_values

  depends_on = [kubernetes_namespace_v1.namespace]
}

resource "helm_release" "argo_events" {
  name             = "argo-events"
  repository       = var.argo_helm_repo
  chart            = "argo-events"
  version          = var.argo_events_chart_version
  namespace        = var.system_namespace
  create_namespace = false
  values           = var.argo_events_values

  depends_on = [kubernetes_namespace_v1.namespace]
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

  depends_on = [kubernetes_namespace_v1.namespace]
}

# The controller needs no identity: ClusterSecretStores authenticate via serviceAccountRef.

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

resource "kubernetes_service_account_v1" "federated" {
  for_each = var.federated_service_accounts

  metadata {
    name      = coalesce(each.value.name, each.key)
    namespace = each.value.namespace
    annotations = {
      "azure.workload.identity/client-id" = each.value.client_id
    }
    labels = {
      "azure.workload.identity/use" = "true"
    }
  }

  depends_on = [kubernetes_namespace_v1.namespace]
}

resource "kubectl_manifest" "kubernetes_object" {
  for_each = { for d in local.manifest_documents : d.key => d if !d.is_sa_token }

  yaml_body          = each.value.body
  override_namespace = each.value.namespace

  # Some manifests depend on state created later in this apply; waiting would deadlock.
  wait_for_rollout = false

  depends_on = [helm_release.argo_workflows, helm_release.argo_events, helm_release.argocd]
}

resource "kubectl_manifest" "extra" {
  for_each = { for d in local.kubectl_manifest_documents : d.key => d if !d.is_sa_token }

  yaml_body          = each.value.body
  override_namespace = each.value.namespace

  wait_for_rollout = false

  depends_on = [helm_release.external_secrets, kubernetes_service_account_v1.federated, helm_release.argo_workflows, helm_release.argo_events, helm_release.argocd]
}

# A service-account-token Secret is deleted by Kubernetes if its
# ServiceAccount does not exist yet, so these are applied after every other
# caller-supplied manifest instead of in parallel with them.
resource "kubectl_manifest" "service_account_token" {
  for_each = merge(
    { for d in local.manifest_documents : "manifest-${d.key}" => d if d.is_sa_token },
    { for d in local.kubectl_manifest_documents : "kubectl-${d.key}" => d if d.is_sa_token },
  )

  yaml_body          = each.value.body
  override_namespace = try(each.value.namespace, null)

  wait_for_rollout = false

  depends_on = [kubectl_manifest.kubernetes_object, kubectl_manifest.extra]
}

resource "local_file" "rendered_manifest" {
  for_each = var.rendered_manifest_files

  filename = "${path.module}/.rendered/${each.value.file_name}"
  content  = each.value.content
}
