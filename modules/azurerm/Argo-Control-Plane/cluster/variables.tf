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

variable "resource_group_name" {
  type        = string
  description = "Resource group for the control plane (AKS, VNet, NAT Gateway, Key Vaults, Bastion)"
}

variable "create_resource_group" {
  type        = bool
  description = "Whether this module creates resource_group_name itself. Set to false to point at a resource group already managed elsewhere."
  default     = true
}

variable "create_role_assignments" {
  type        = bool
  description = "Whether to create the azurerm_role_assignment resources for ESO's Key Vault and the artifact storage account. Requires Owner or User Access Administrator at those scopes - a plain Contributor gets a 403. The KMS role assignments are gated by enable_secrets_encryption instead, since KMS can't work without them."
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
  description = "Name of the control plane's virtual network"
}

variable "vnet_address_space" {
  type        = string
  description = "Address space for the VNet, e.g. 10.4.0.0/16"
}

variable "node_subnet_address_prefix" {
  type        = string
  description = "CIDR for the AKS node subnet"
}

variable "network_security_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = optional(string, "*")
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = optional(string, "*")
  }))
  description = "Additional rules on the node subnet's NSG, beyond Azure's default rules"
  default     = []
}

variable "aks_cluster_name" {
  type        = string
  description = "Name of the AKS cluster. Also the prefix for every other resource name this module derives."
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
  description = "Entra ID group object IDs granted AKS cluster-admin via native Azure RBAC for Kubernetes. The identity running terraform apply must be in one of these to apply the apps module."
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
  description = "CIDR block for Kubernetes Services - must not overlap the VNet"
}

variable "dns_service_ip" {
  type        = string
  description = "DNS service IP, must be inside service_cidr"
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "Resource ID of an existing Log Analytics Workspace for AKS's oms_agent. Null disables Container Insights."
  default     = null
}

variable "node_vm_size" {
  type        = string
  description = "VM size for the shared node pool"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones for the shared node pool. NATS JetStream runs 3 replicas regardless, so use 3 zones for real node-level HA."
  default     = ["1", "2", "3"]

  validation {
    condition     = length(var.availability_zones) >= 2
    error_message = "At least 2 availability zones are required for basic node-level HA."
  }
}

variable "node_min_count" {
  type        = number
  description = "Minimum node count for the shared node pool's autoscaler"
  default     = 2
}

variable "node_max_count" {
  type        = number
  description = "Maximum node count for the shared node pool's autoscaler"
  default     = 4
}

variable "enable_bastion" {
  type        = bool
  description = "Whether to provision Azure Bastion for admin access"
  default     = true
}

variable "bastion_subnet_address_prefix" {
  type        = string
  description = "CIDR for the AzureBastionSubnet (/26 or larger) - required when enable_bastion is true"
  default     = null
}

variable "bastion_allow_https_internet_inbound" {
  type        = bool
  description = "Whether Bastion accepts inbound from the whole internet vs. only bastion_public_address_prefixes"
  default     = false
}

variable "bastion_public_address_prefixes" {
  type        = list(string)
  description = "Source CIDRs allowed to reach Bastion when bastion_allow_https_internet_inbound is false"
  default     = []
}

variable "enable_secrets_encryption" {
  type        = bool
  description = "Whether to create a Key Vault + key and enable AKS's KMS etcd encryption with it. Can only be turned on in a follow-up apply after the cluster exists, never the apply that first creates it."
  default     = false
}

variable "cluster_secrets_key_vault_name" {
  type        = string
  description = "Override for the KMS Key Vault's name (globally unique, <=24 chars). Null derives \"<aks_cluster_name>-kms\"."
  default     = null
}

variable "eso_namespace" {
  type        = string
  description = "Namespace External Secrets Operator runs in - scopes ESO's federated identity subject. Must match the apps module's eso_namespace."
  default     = "external-secrets"
}

variable "eso_key_vault_name" {
  type        = string
  description = "Override for ESO's Key Vault name (globally unique, <=24 chars). Null derives \"<aks_cluster_name>-secrets\"."
  default     = null
}

variable "log_retention_in_days" {
  type        = number
  description = "Retention for NSG Flow Logs and the artifact storage account's blob expiration, if enabled"
  default     = 90
}

variable "enable_vpc_flow_logs" {
  type        = bool
  description = "Whether to create NSG Flow Logs for the node subnet's NSG, published to a dedicated storage account"
  default     = false
}

variable "network_watcher_name" {
  type        = string
  description = "Name of the region's existing Network Watcher - required when enable_vpc_flow_logs is true"
  default     = null
}

variable "network_watcher_resource_group_name" {
  type        = string
  description = "Resource group containing network_watcher_name - required when enable_vpc_flow_logs is true"
  default     = null
}

variable "enable_artifact_archiving" {
  type        = bool
  description = "Whether to create a Storage Account + container + Workload Identity for Argo Workflows to archive logs/artifacts to. Wire the outputs into argo_workflows_values' artifactRepository config."
  default     = false
}

variable "argo_namespace" {
  type        = string
  description = "Namespace Argo Workflows runs in - only used to scope the workflow-controller's federated identity subject when enable_artifact_archiving is true"
  default     = "argo"
}

variable "workflow_controller_service_account_name" {
  type        = string
  description = "ServiceAccount name the argo-workflows Helm chart creates for workflow-controller - only used when enable_artifact_archiving is true"
  default     = "argo-workflows-workflow-controller"
}

variable "argo_logs_storage_account_name" {
  type        = string
  description = "Override for the argo_logs Storage Account name. Names are ForceNew, so pin an already-applied environment's live name here. Null for a fresh environment."
  default     = null
}

variable "flow_logs_storage_account_name" {
  type        = string
  description = "Same override as argo_logs_storage_account_name, for the flow_logs Storage Account"
  default     = null
}
