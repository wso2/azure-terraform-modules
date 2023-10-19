# -------------------------------------------------------------------------------------
#
# Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------
variable "application_name" {}
variable "shortened_project" {}
variable "shortened_environment" {}
variable "location" {}
variable "resource_group_name" {}
variable "account_tier" {}
variable "account_replication_type" {}
variable "default_tags" {}
variable "recovery_vault_name" {}
variable "daily_backup_time" {
  default = "23:00"
}
variable "daily_retention" {
  default = "7"
}

variable "storage_account_network_rules_default_action" {
  default = "Allow"
}

variable "storage_account_network_rules_bypass" {
  default = ["AzureServices", "Metrics"]
}

variable "storage_account_network_rules_ip_rules" {
  default = []
}

variable "storage_account_network_rules_virtual_network_subnet_ids" {
  default = []
}

variable "shortened_location" {}
variable "shortened_padding" {}

variable "allow_nested_items_to_be_public" {
  description = "Allow or disallow nested items within this Account to opt into being public"
  type        = bool
  default     = false
}

variable "advanced_threat_protection_enabled" {
  default = true
  type = bool
  description = "Enable Advance Threat protection for Storage account"
}
