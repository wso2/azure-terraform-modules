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

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}

variable "location" {
  description = "Azure location where the resource exists"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which the EventHub Namespace exists"
  type        = string
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account"
  type        = string
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account"
  type        = string
}

variable "tags" {
  description = "Tags to be used in resources"
  type        = map(string)
}

variable "index_document" {
  description = "The name of the index document."
  type        = string
}

variable "error_document" {
  description = "The name of the error document."
  type        = string
}

variable "network_rules_ip_whitelist" {
  default     = []
  description = "List of IP addresses or ranges to whitelist for storage account via firewall. Defaults to []"
  type        = list(string)
}

variable "network_rules_default_action" {
  default     = "Deny"
  description = "The default action of allow or deny when no other rules match"
  type        = string
}

variable "network_rules_subnet_ids" {
  default     = []
  description = "List of subnet IDs to whitelist for storage account via firewall. Defaults to []"
  type        = list(string)
}

variable "allow_nested_items_to_be_public" {
  default     = false
  description = "Allow or disallow nested items within this Account to opt into being public"
  type        = bool
}

variable "network_rules_bypass" {
  default     = []
  description = "List of actions that bypass the network rule. Defaults to []"
  type        = list(string)
}
