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
variable "shortened_project" {
  description = "The shortened project name"
  type        = string
}

variable "application_name" {
  description = "Name of the resource"
  type        = string
}

variable "location" {
  description = "Azure location where the resource exists"
  type        = string
}

variable "shortened_environment" {
  description = "Shortened name for environment of the project in which this resource is deployed"
  type        = string
}

variable "shortened_location" {
  description = "Shortened name for the Azure location where the resource exists"
  type        = string
}

variable "shortened_padding" {
  description = "Shortened padding for the resource name"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which the EventHub Namespace exists"
  type        = string
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account"
  type        = string
}

variable "default_tags" {
  description = "Default tags to be used in resources"
  type        = map(string)
}

variable "default_action" {
  description = "The default action of allow or deny when no other rules match"
  type        = string
  default     = "Allow"
}

variable "delete_retention_days_policy" {
  description = "The number of days that the blob should be retained, between 1 and 365 days"
  type        = number
  default     = 7
}

variable "access_tier" {
  description = "The access tier for BlobStorage accounts"
  type        = string
  default     = "Hot"
}

variable "storage_account_network_rules_ip_rules" {
  description = "List of public IP or IP ranges in CIDR Format"
  type        = list(string)
  default     = []
}

variable "allow_nested_items_to_be_public" {
  description = "Allow or disallow nested items within this Account to opt into being public"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Whether the public network access is enabled?"
  type        = bool
  default     = true
}
