# -------------------------------------------------------------------------------------
#
# Copyright (c) 2023, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "key_vault_name" {
  description = "The name of the Key Vault."
  type        = string
}

variable "location" {
  description = "value of the location"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Key Vault."
  type        = string
}

variable "sku_name" {
  description = "The Name of the SKU used for this Key Vault."
  type        = string
}

variable "vault_access_tenant_id" {
  description = "The Tenant ID for the Azure Active Directory Tenant where the Key Vault exists."
  type        = string
}

variable "tags" {
  description = "Tags for the Key Vault."
  type        = map(string)
}

variable "network_acls_default_action" {
  default     = "Deny"
  description = "The Default Action for the Network ACLs."
  type        = string
}

variable "enable_vault_rbac_authorization" {
  default     = "false"
  description = "Boolean flag to specify whether Azure RBAC should be used for Access Control for the Key Vault. Defaults to false"
  type        = bool
}

variable "enabled_for_disk_encryption" {
  default     = "false"
  description = "Boolean flag to specify whether Azure Disk Encryption should be permitted to retrieve secrets from the vault. Defaults to false"
  type        = bool
}

variable "network_acls_bypass" {
  default     = "AzureServices"
  description = "Specifies which traffic can bypass the network rules. Possible values are AzureServices and None"
  type        = string
}

variable "network_acls_ip_rules" {
  default     = []
  description = "One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault"
  type        = list(string)
}

variable "network_acl_vnet_subnet_ids" {
  default     = []
  description = "One or more virtual network subnet ids which should be able to access the Key Vault"
  type        = list(string)
}

variable "soft_delete_retention_days" {
  default     = 7
  description = "The number of days that items should be retained for once soft-deleted. Defaults to 7"
  type        = number
}

variable "enabled_for_template_deployment" {
  default     = false
  description = "Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false"
  type        = bool
}

variable "purge_protection_enabled" {
  default     = true
  description = "Indicate if the keyvault is enabled with purge protection"
  type        = bool
}

variable "key_vault_name_abbreviation" {
  description = "The abbreviation of the resource name."
  type        = string
  default     = "kv"
}
