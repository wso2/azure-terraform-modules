# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------


variable "location" {}
variable "resource_group_name" {}
variable "sku_name" {}
variable "vault_access_tenant_id" {}
variable "default_tags" {}
variable "application_name" {}
variable "shortened_padding" {}
variable "workload" {
  default = ""
}
variable "network_acls_default_action" {
  default = "Deny"
}

variable "enable_vault_rbac_authorization" {
  default = "false"
}
variable "enabled_for_disk_encryption" {
  default = "false"
}

variable "network_acls_bypass" {
  default = "AzureServices"
}

variable "network_acls_ip_rules" {
  default     = []
  description = "One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault"
}

variable "network_acl_vnet_subnet_ids" {
  default     = []
  description = "One or more virtual network subnet ids which should be able to access the Key Vault"
}

variable "soft_delete_retention_days" {
  default = 7
}

variable "shortened_environment" {}
variable "shortened_project" {}
variable "shortened_location" {}
variable "enabled_for_template_deployment" {
  default     = false
  description = "Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false"
}

variable "purge_protection_enabled" {
  description = "Indicate if the keyvault is enabled with purge protection"
  default     = true
}
