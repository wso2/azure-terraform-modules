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
# Every variable below is a straight passthrough into module.cluster or
# module.apps (see main.tf) - same name, type, description and default as
# that submodule's own variables.tf.
#
# Unlike the AWS composites, no apps variable is auto-wired from a cluster
# output here: federated_service_accounts stays a plain passthrough: a
# caller composing through this module builds its value from this
# module's own deploy_identity_client_ids output (see outputs.tf).
#
# --------------------------------------------------------------------------------------

# --- Passed to module.cluster ---

variable "resource_group_name" {
  type        = string
  description = "Resource group for the data plane (AKS, VNet, NAT Gateways, Bastion)"
}

variable "create_resource_group" {
  type        = bool
  description = "Whether this module creates resource_group_name itself. Defaults to true; set to false to point at a resource group already managed elsewhere."
  default     = true
}

variable "create_role_assignments" {
  type        = bool
  description = "Whether to create the azurerm_role_assignment resources this module wires up. Requires Owner or User Access Administrator at the relevant scope - a plain Contributor gets a 403. Set to false to create the identities/federated credentials without granting roles."
  default     = true
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to resources created by this module"
  default     = {}
}

variable "vnet_name" {
  type        = string
  description = "Name of the data plane's virtual network"
}

variable "vnet_address_space" {
  type        = string
  description = "Address space for the VNet, e.g. 10.2.0.0/16"
}

variable "aks_cluster_name" {
  type        = string
  description = "Name of the AKS cluster"
}

variable "aks_dns_prefix" {
  type        = string
  description = "DNS prefix for the AKS cluster"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}

variable "aks_admin_username" {
  type        = string
  description = "Admin username for AKS nodes"
  default     = "azureuser"
}

variable "aks_public_ssh_key_path" {
  type        = string
  description = "Path to the public SSH key file for AKS nodes"
}

variable "aks_admin_group_object_ids" {
  type        = list(string)
  description = "Entra ID group object IDs granted AKS cluster-admin via native Azure RBAC for Kubernetes (no unified cross-cloud identity layer)"
  default     = []
}

variable "private_cluster_enabled" {
  type        = bool
  description = "Whether the AKS API server has a private-only endpoint"
  default     = false
}

variable "api_server_authorized_ip_ranges" {
  type        = list(string)
  description = "Authorized IP ranges for the public API server endpoint, if not private"
  default     = []
}

variable "service_cidr" {
  type        = string
  description = "CIDR block for Kubernetes Services"
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "Resource ID of an existing Log Analytics Workspace for AKS's oms_agent. This module does not create one - pass an existing workspace's ID."
}

variable "dns_service_ip" {
  type        = string
  description = "DNS service IP, must be inside service_cidr"
}

variable "stage_subnet_address_prefix" {
  type        = string
  description = "CIDR for the stage tier's node pool subnet"
}

variable "internal_lb_subnet_address_prefix" {
  type        = string
  description = "CIDR for AKS's internal load balancer subnet (shared infra, not tier-specific)"
}

variable "stage_node_vm_size" {
  type        = string
  description = "VM size for the stage tier's default AKS node pool"
}

variable "stage_availability_zones" {
  type        = list(number)
  description = "Availability zones for the stage tier's default AKS node pool"
  default     = [1, 2, 3]
}

variable "stage_node_min_count" {
  type        = number
  description = "Minimum node count for the stage tier's default node pool autoscaler"
  default     = 1
}

variable "stage_node_max_count" {
  type        = number
  description = "Maximum node count for the stage tier's default node pool autoscaler"
  default     = 3
}

variable "prod_subnet_address_prefix" {
  type        = string
  description = "CIDR for the prod tier's dedicated subnet"
}

variable "prod_node_vm_size" {
  type        = string
  description = "VM size for the prod tier's separate, tainted AKS node pool"
}

variable "prod_availability_zones" {
  type        = list(string)
  description = "Availability zones for the prod tier's separate, tainted AKS node pool"
  default     = ["1", "2", "3"]
}

variable "prod_node_min_count" {
  type        = number
  description = "Minimum node count for the prod tier node pool's autoscaler"
  default     = 1
}

variable "prod_node_max_count" {
  type        = number
  description = "Maximum node count for the prod tier node pool's autoscaler"
  default     = 3
}

variable "prod_node_taint_value" {
  type        = string
  description = "Value for the env taint applied to prod nodes (e.g. \"env=prod:NoSchedule\") so only workloads that explicitly tolerate it land there"
  default     = "prod"
}

variable "enable_bastion" {
  type        = bool
  description = "Whether to provision Azure Bastion for admin access to this data plane"
  default     = true
}

variable "bastion_subnet_address_prefix" {
  type        = string
  description = "CIDR for the AzureBastionSubnet (must be /26 or larger per Azure's requirement)"
  default     = null
}

variable "bastion_allow_https_internet_inbound" {
  type        = bool
  description = "Whether the Bastion host accepts inbound from the public internet vs. only from public_address_prefixes"
  default     = false
}

variable "bastion_public_address_prefixes" {
  type        = list(string)
  description = "Source CIDRs allowed to reach Bastion when bastion_allow_https_internet_inbound is false"
  default     = []
}

variable "deploy_identities" {
  type = map(object({
    namespace            = string
    service_account_name = string
  }))
  description = "Per-env Workload Identity Federation identities for pipeline pods - one User-Assigned Managed Identity + Federated Identity Credential per map entry, trusted via this cluster's own OIDC issuer and scoped to a (namespace, ServiceAccount) subject. This module only creates the identity; permissions come from deploy_identity_role_assignments below."
  default     = {}
}

variable "deploy_identity_role_assignments" {
  type = list(object({
    identity_key         = string # must match a key in deploy_identities
    role_definition_name = string
    scope                = string
  }))
  description = "Azure RBAC role assignments granting each deploy identity access to its real deployment target - a list (not a map) since one identity may need more than one role/scope."
  default     = []
}

variable "enable_secrets_encryption" {
  type        = bool
  description = "Whether to create a Key Vault + key and enable AKS's etcd secrets encryption with it. Can only be turned on in a follow-up apply after the cluster already exists, never the apply that first creates it."
  default     = false
}

variable "log_retention_in_days" {
  type        = number
  description = "Retention for NSG Flow Logs and the S3-equivalent artifact storage account's blob expiration, if enabled"
  default     = 90
}

variable "enable_vpc_flow_logs" {
  type        = bool
  description = "Whether to create NSG Flow Logs for the stage and prod network security groups, published to a dedicated storage account"
  default     = false
}

variable "network_watcher_name" {
  type        = string
  description = "Name of the region's existing Network Watcher - required when enable_vpc_flow_logs is true. Caller-supplied rather than assumed, since org policy can disable Azure's auto-created one."
  default     = null
}

variable "network_watcher_resource_group_name" {
  type        = string
  description = "Resource group containing network_watcher_name - required when enable_vpc_flow_logs is true"
  default     = null
}

variable "enable_artifact_archiving" {
  type        = bool
  description = "Whether to create a Storage Account + container + Workload Identity Federation identity for Argo Workflows to archive workflow logs/artifacts to. Wire the two outputs into argo_workflows_values' artifactRepository config."
  default     = false
}

variable "argo_namespace" {
  type        = string
  description = "Kubernetes namespace Argo Workflows runs in - only used to scope the workflow-controller's federated identity subject when enable_artifact_archiving is true"
  default     = "argo"
}

variable "workflow_controller_service_account_name" {
  type        = string
  description = "ServiceAccount name the argo-workflows Helm chart creates for workflow-controller - only used to scope the federated identity subject when enable_artifact_archiving is true"
  default     = "argo-workflows-workflow-controller"
}

variable "argo_logs_storage_account_name" {
  type        = string
  description = "Explicit override for the argo_logs Storage Account name. Storage account names are ForceNew, so an already-applied environment must pin its current live name here rather than pick up a naming-algorithm change. Leave null for a fresh environment."
  default     = null
}

variable "flow_logs_storage_account_name" {
  type        = string
  description = "Same override as argo_logs_storage_account_name, for the flow_logs Storage Account."
  default     = null
}

# --- Passed to module.apps ---

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
    name      = optional(string)
  }))
  description = "ServiceAccounts to create, each annotated with azure.workload.identity/client-id - the identity a ClusterSecretStore's serviceAccountRef (or other Workload-Identity-authenticated workload) presents. client_id should come from the cluster module's deploy_identity_client_ids output. The k8s object's own name is `name` if set, else the map key."
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
