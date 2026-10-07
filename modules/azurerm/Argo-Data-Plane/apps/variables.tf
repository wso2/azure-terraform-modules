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
  description = "Argo Workflows Helm chart version. Pinned so every apply and both clouds install the same release; bump it deliberately."
  default     = "2.0.6"
}

variable "argo_events_chart_version" {
  type        = string
  description = "Argo Events Helm chart version. Pinned so every apply and both clouds install the same release; bump it deliberately."
  default     = "2.4.27"
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
  description = "ArgoCD Helm chart version. Pinned so every apply and both clouds install the same release; bump it deliberately."
  default     = "10.9.1"
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
  type        = string
  description = "External Secrets Operator Helm chart version. Pinned so every apply and both clouds install the same release; bump it deliberately."
  default     = "2.11.0"
}

variable "eso_helm_repo" {
  type        = string
  description = "Helm repository URL for the External Secrets Operator chart."
  default     = "https://charts.external-secrets.io"
}

variable "eso_namespace" {
  type        = string
  description = "Namespace External Secrets Operator is installed into. Must match the cluster module's eso_namespace."
  default     = "external-secrets"
}

variable "federated_service_accounts" {
  type = map(object({
    namespace = string
    client_id = string
    # Defaults to the map key; set it to reuse a name across namespaces.
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

variable "group_role_bindings" {
  type = map(object({
    group_object_id = string
    namespace       = string
    cluster_role    = optional(string, "edit")
  }))
  description = "Per-namespace Kubernetes access for Entra ID groups, keyed by any stable label. Binds the group to a built-in ClusterRole (view, edit or admin) inside one namespace, which must exist already or come from this module's manifests."
  default     = {}
}
