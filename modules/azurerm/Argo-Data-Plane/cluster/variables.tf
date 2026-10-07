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
  description = "Whether to create the azurerm_role_assignment resources this module wires up. Requires Owner or User Access Administrator at the relevant scope - a plain Contributor gets a 403. Set to false to create the identities/federated credentials without granting roles; the cluster identity's Network Contributor grant on the VNet must then be made out of band before the cluster is created."
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

variable "aks_public_ssh_key" {
  type        = string
  description = "Public SSH key content for AKS nodes (e.g. \"ssh-ed25519 AAAA... user@host\"), not a file path - keeps this module from depending on a key file existing on whatever machine runs terraform apply"
}

variable "aks_admin_group_object_ids" {
  type        = list(string)
  description = "Entra ID group object IDs granted AKS cluster-admin via native Azure RBAC for Kubernetes (no unified cross-cloud identity layer)"
  default     = []
}

variable "private_cluster_enabled" {
  type        = bool
  description = "Whether the AKS API server has a private-only endpoint. Default true, matching the AWS modules' private EKS endpoint. A private cluster is reached through enable_bastion + enable_jump_vm; set this false only together with api_server_authorized_ip_ranges."
  default     = true
}

variable "api_server_authorized_ip_ranges" {
  type        = list(string)
  description = "Authorized IP ranges for the public API server endpoint, if not private. Empty means the endpoint accepts connections from any address (Entra ID sign-in is still required); set this or private_cluster_enabled for anything beyond a test cluster. Include the cluster's own NAT gateway addresses, since nodes reach the API server through them."
  default     = []
}

variable "local_account_disabled" {
  type        = bool
  description = "Disable the cluster's local admin account, so every sign-in goes through Entra ID and Azure RBAC. Only enable once aks_admin_group_object_ids (or an Azure RBAC role assignment) gives someone admin access, otherwise the cluster is unreachable."
  default     = false
}

variable "service_cidr" {
  type        = string
  description = "CIDR block for Kubernetes Services"
}

variable "pod_cidr" {
  type        = string
  description = "CIDR block for pod IPs under Azure CNI Overlay. Must not overlap vnet_address_space or service_cidr - pod IPs are overlay-only and never routed on the VNet, so this can be sized independently of subnet space"
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "Resource ID of an existing Log Analytics Workspace for AKS's oms_agent. This module does not create one - pass an existing workspace's ID. Null disables Container Insights."
  default     = null
}

variable "dns_service_ip" {
  type        = string
  description = "DNS service IP, must be inside service_cidr"
}

# --- Dedicated system pool ---
#
# A small, always-on System-mode pool outside both tiers' subnets, so
# kube-system components (konnectivity-agent, metrics-server, CoreDNS)
# aren't stuck on the stage pool - which the prod NSG's deny rule then
# cuts off from reaching prod kubelets/pods for logs, exec and metrics.

variable "system_subnet_address_prefix" {
  type        = string
  description = "CIDR for the dedicated system pool's subnet - outside both tiers' subnets and their NSG rules, so it isn't affected by the prod tier's deny-from-stage rule. With Azure CNI Overlay this only needs to cover node IPs, not pod IPs, so it can be small (e.g. /27)"
}

variable "system_node_vm_size" {
  type        = string
  description = "VM size for the dedicated system pool"
}

variable "system_availability_zones" {
  type        = list(number)
  description = "Availability zones for the dedicated system pool"
  default     = [1]
}

variable "system_node_min_count" {
  type        = number
  description = "Minimum node count for the dedicated system pool's autoscaler"
  default     = 1
}

variable "system_node_max_count" {
  type        = number
  description = "Maximum node count for the dedicated system pool's autoscaler"
  default     = 2
}

# --- Stage tier ---

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
  description = "VM size for the stage tier's node pool"
}

variable "stage_availability_zones" {
  type        = list(number)
  description = "Availability zones for the stage tier's node pool"
  default     = [1, 2, 3]
}

variable "stage_node_min_count" {
  type        = number
  description = "Minimum node count for the stage tier's node pool autoscaler"
  default     = 1
}

variable "stage_node_max_count" {
  type        = number
  description = "Maximum node count for the stage tier's node pool autoscaler"
  default     = 3
}

# --- Prod tier ---

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

# --- Bastion ---

variable "enable_bastion" {
  type        = bool
  description = "Whether to provision Azure Bastion for admin access to this data plane. Default false, since bastion_subnet_address_prefix has no usable default - set both together"
  default     = false
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
  description = "Whether to create a Key Vault + key and enable AKS's etcd secrets encryption with it."
  default     = false
}

variable "cluster_secrets_key_vault_name" {
  type        = string
  description = "Override for the KMS Key Vault's name (globally unique, <=24 chars). Null derives \"<aks_cluster_name>-kv\"."
  default     = null
}

variable "log_retention_in_days" {
  type        = number
  description = "Retention for VNet flow logs and the S3-equivalent artifact storage account's blob expiration, if enabled"
  default     = 90
}

variable "enable_vpc_flow_logs" {
  type        = bool
  description = "Whether to create a VNet flow log for this module's VNet, published to a dedicated storage account"
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

variable "enable_jump_vm" {
  type        = bool
  description = "Whether to provision a small Linux VM with az, kubectl and kubelogin, reachable only through Bastion. Needed to reach the API server when private_cluster_enabled is true, since Bastion itself only forwards SSH and RDP. Requires enable_bastion."
  default     = false
}

variable "jump_vm_subnet_address_prefix" {
  type        = string
  description = "CIDR for the jump VM's own subnet (/29 or larger) - required when enable_jump_vm is true"
  default     = null
}

variable "jump_vm_size" {
  type        = string
  description = "VM size for the jump VM"
  default     = "Standard_B2s"
}

variable "jump_vm_access" {
  type = map(object({
    principal_id = string
    sudo         = optional(bool, false)
  }))
  description = "Entra ID groups (or users) allowed to reach the cluster through Bastion and the jump VM, keyed by any stable label. Each gets Entra SSH login on the VM (with sudo if set), Reader on the VM, its NIC and the Bastion host, and the AKS Cluster User role. Add people to the group rather than to this map. Only created when create_role_assignments is true. This grants the path in, not Kubernetes permissions - pair it with aks_admin_group_object_ids or the apps module's group_role_bindings."
  default     = {}
}
