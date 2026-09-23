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
# Assumes the caller has already configured the kubernetes/helm providers
# against the sibling ../cluster module - takes no cluster credentials as
# input. Same manifest_files pattern as Argo-EKS-DataPlane/apps for
# caller-supplied, project-specific YAML.
#
# --------------------------------------------------------------------------------------

variable "namespaces" {
  type        = list(string)
  description = "Per-tier Kubernetes namespaces (e.g. [\"argo-stage\", \"argo-prod\"]) created by this module. Argo Workflows/Events install once cluster-wide in system_namespace; RBAC via manifest_files is what isolates tiers."
}

variable "system_namespace" {
  type        = string
  description = "Namespace for the single shared argo-server/workflow-controller/argo-events install"
  default     = "argo"
}

variable "argo_workflows_chart_version" {
  type        = string
  description = "Argo Workflows Helm chart version. Null uses the chart repo's latest."
  default     = null
}

variable "argo_events_chart_version" {
  type        = string
  description = "Argo Events Helm chart version. Null uses the chart repo's latest."
  default     = null
}

variable "argo_helm_repo" {
  type        = string
  description = "Helm repository hosting the argo-workflows and argo-events charts"
  default     = "https://argoproj.github.io/argo-helm"
}

variable "argo_workflows_values" {
  type        = list(string)
  description = "Helm values overrides (YAML strings, later entries win) for the argo-workflows release. Set controller.workflowNamespaces to var.namespaces to narrow the watch."
  default     = []
}

variable "argo_events_values" {
  type        = list(string)
  description = "Helm values overrides (YAML strings, later entries win) for the argo-events release"
  default     = []
}

variable "install_argocd" {
  type        = bool
  description = "Whether to install ArgoCD on this cluster"
  default     = true
}

variable "argocd_namespace" {
  type        = string
  description = "Namespace for the ArgoCD installation"
  default     = "argocd"
}

variable "argocd_chart_version" {
  type        = string
  description = "ArgoCD Helm chart version. Null uses the chart repo's latest."
  default     = null
}

variable "argocd_helm_repo" {
  type        = string
  description = "Helm repository hosting the argo-cd chart"
  default     = "https://argoproj.github.io/argo-helm"
}

variable "argocd_values" {
  type        = list(string)
  description = "Helm values overrides (YAML strings, later entries win) for the argo-cd release"
  default     = []
}

variable "manifest_files" {
  type = list(object({
    location     = optional(string)
    content      = optional(string)
    template_map = optional(map(string), {})
    namespace    = optional(string)
  }))
  description = "Additional Kubernetes manifests to apply after the Helm releases above - e.g. debug-access RBAC, EventSource/Sensor definitions, ArgoCD Application/AppProject objects. Set content directly to pass already-fetched text instead of a location file path. namespace, if set, overrides each object's own metadata.namespace."
  default     = []
}

variable "install_external_secrets" {
  type        = bool
  description = "Install External Secrets Operator, syncing this data plane's IS-deploy tier secrets from Azure Key Vault via Workload Identity."
  default     = true
}

variable "eso_chart_version" {
  type    = string
  default = null
}

variable "eso_helm_repo" {
  type    = string
  default = "https://charts.external-secrets.io"
}

variable "eso_namespace" {
  type    = string
  default = "external-secrets"
}

variable "federated_service_accounts" {
  type = map(object({
    namespace = string
    client_id = string
    # Optional - defaults to the map key when unset. Lets two entries
    # share the same ServiceAccount name in different namespaces, since
    # this map's own keys must be unique.
    name = optional(string)
  }))
  description = "ServiceAccounts to create, each annotated with azure.workload.identity/client-id - the identity a ClusterSecretStore's serviceAccountRef (or any other Workload-Identity-authenticated workload) presents. client_id should come from the cluster module's deploy_identity_client_ids output for a matching (namespace, name) entry in its deploy_identities. The k8s object's own name is `name` if set, else the map key itself."
  default     = {}
}

variable "kubectl_manifest_files" {
  type = list(object({
    location     = optional(string)
    content      = optional(string)
    template_map = optional(map(string), {})
    namespace    = optional(string)
  }))
  description = "Manifests applied via the kubectl provider instead of kubernetes_manifest - required for anything backed by a CRD installed in this same apply (e.g. ESO's ClusterSecretStore/ExternalSecret). namespace, if set, overrides each object's own metadata.namespace."
  default     = []
}

variable "rendered_manifest_files" {
  type = map(object({
    file_name = string
    content   = string
  }))
  description = "Writes each entry's content to a local file at <module_path>/.rendered/<file_name>, for inspecting rendered manifest content - never applied to the cluster. Map key is arbitrary, only used to identify the resource instance."
  default     = {}
}
