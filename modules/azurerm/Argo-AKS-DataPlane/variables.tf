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
# Unlike the AWS composites (Argo-Control-Plane, Argo-EKS-DataPlane), there
# is no apps variable auto-wired from a cluster output here: apps has no
# eso_role_arn-shaped input at all (ESO on AKS authenticates via Workload
# Identity, not an IRSA-style role ARN), and the one place cluster outputs
# genuinely feed into apps - federated_service_accounts' client_id fields,
# sourced from module.cluster.deploy_identity_client_ids - is a fully
# caller-composed map in every real environment (arbitrary keys, a
# caller-chosen k8s object name via `name`, and namespaces that don't
# mechanically derive from deploy_identities' own keys - see
# environments/azure-dataplane/main.tf's own federated_service_accounts
# block). Auto-deriving that map here would be guessing at a shape the
# real environment doesn't actually use uniformly, so federated_service_accounts
# stays a plain passthrough - a caller composing through this module can
# still build its value from this module's own deploy_identity_client_ids
# output (see outputs.tf).
#
# --------------------------------------------------------------------------------------

# --- Passed to module.cluster ---

variable "resource_group_name" {
  type        = string
  description = "Resource group for the data plane (AKS, VNet, NAT Gateways, Bastion)"
}

variable "create_resource_group" {
  type        = bool
  description = "Whether this module creates resource_group_name itself. Defaults to true so the module is self-contained; set to false to point at a resource group already managed elsewhere (e.g. by a platform team) instead of having this module own its lifecycle."
  default     = true
}

variable "create_role_assignments" {
  type        = bool
  description = "Whether to create the azurerm_role_assignment resources this module wires up (workflow artifact storage access, deploy_identity_role_assignments). Requires Microsoft.Authorization/roleAssignments/write at the relevant scope (Owner or User Access Administrator) - a plain Contributor identity gets a 403 on these specifically. Set to false to still create the identities/federated credentials but skip granting them roles, until that permission exists or someone else grants the roles out-of-band."
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
  description = "Per-env Workload Identity Federation identities for pipeline pods (\"Pipeline pod -> deployment target: Cloud-native Workload Identity Federation / IRSA, scoped per env\" per the security review doc). One User-Assigned Managed Identity + Federated Identity Credential per map entry, trusted via this cluster's own OIDC issuer and scoped to exactly that (namespace, ServiceAccount) subject. This module only creates the identity - actual permissions are granted via deploy_identity_role_assignments below, since what a pipeline needs to reach is caller-specific."
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
  description = "Whether to create a Key Vault + key and enable AKS's etcd secrets encryption (key_management_service) with it. See the key_management_service block's own comment - this can only be turned on in a follow-up apply after the cluster already exists, never on the same apply that first creates it."
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
  description = "Name of the region's existing Network Watcher - required when enable_vpc_flow_logs is true. Azure auto-creates one per region by default (e.g. \"NetworkWatcher_<region>\"), but org policy can disable this, so it's caller-supplied rather than assumed."
  default     = null
}

variable "network_watcher_resource_group_name" {
  type        = string
  description = "Resource group containing network_watcher_name - required when enable_vpc_flow_logs is true"
  default     = null
}

variable "enable_artifact_archiving" {
  type        = bool
  description = "Whether to create a Storage Account + container + Workload Identity Federation identity for Argo Workflows to archive workflow logs/artifacts to (workflow_controller_artifacts_client_id/artifact_storage_account_name outputs). The caller still wires these into argo_workflows_values' artifactRepository Helm config."
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
  description = "Explicit override for the argo_logs Storage Account name. Storage account names are ForceNew (renaming destroys and recreates the real Azure resource, losing any archived logs), so an already-applied environment must pin its current live name here rather than pick up a naming-algorithm change. Leave null for a fresh environment - the default below always reserves exactly enough room for the full \"argologs\" suffix so it's never truncated mid-word."
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
  description = "Per-tier Kubernetes namespaces (e.g. [\"argo-stage\", \"argo-prod\"]) - created by this module, but Argo Workflows/Events themselves install once, cluster-wide, in system_namespace, not per entry here. RBAC (applied via manifest_files) is what actually isolates tiers, matching the security review doc's stated design."
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
  description = "Helm values overrides (YAML strings, later entries win) for the argo-workflows release. Set controller.workflowNamespaces to var.namespaces (or leave cluster-wide) depending on how narrow you want the watch."
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
  description = "Additional Kubernetes manifests to apply after the Helm releases above - e.g. debug-access RBAC, EventSource/Sensor definitions, ArgoCD Application/AppProject objects, ExternalSecrets/ClusterSecretStore for Workload Identity. Content and ordering are entirely caller-supplied. Set content directly to pass already-fetched text instead of rendering location as a local file path. namespace, if set, overrides every object's own embedded metadata.namespace via kubectl_manifest's override_namespace - lets one unmodified source file (no hardcoded namespace, or a namespace meant for a different context) be applied into a different namespace per caller, e.g. the same executor/pipeline WorkflowTemplate applied once per (cloud x env) namespace."
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
  description = "ServiceAccounts to create, each annotated with azure.workload.identity/client-id - the identity a ClusterSecretStore's serviceAccountRef (or any other Workload-Identity-authenticated workload) presents. client_id should come from the cluster module's deploy_identity_client_ids output for a matching (namespace, name) entry in its deploy_identities. The k8s object's own name is `name` if set, else the map key itself. NOT auto-derived by this composite module from var.deploy_identities - see this file's own header comment for why."
  default     = {}
}

variable "kubectl_manifest_files" {
  type = list(object({
    location     = optional(string)
    content      = optional(string)
    template_map = optional(map(string), {})
    namespace    = optional(string)
  }))
  description = "Manifests applied via the alekc/kubectl provider instead of kubernetes_manifest - required for anything backed by a CRD installed in this same apply (ESO's ClusterSecretStore/ExternalSecret). Set content directly to pre-process a real file's text instead of rendering location as-is. namespace, if set, overrides every object's own embedded metadata.namespace, same as manifest_files' namespace."
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
