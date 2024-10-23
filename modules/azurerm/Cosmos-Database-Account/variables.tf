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

variable "cosmosdb_account_name" {
  description = "The name of the Cosmos DB account."
  type        = string
}

variable "location" {
  description = "The Azure Region in which the Cosmos DB account should be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Cosmos DB account."
  type        = string
}

variable "tags" {
  default     = {}
  description = "The tags to assign to the resource."
  type        = map(string)
}

variable "kind" {
  default     = "GlobalDocumentDB"
  description = "The kind of Cosmos DB account to create."
  type        = string
}

variable "offer_type" {
  default     = "Standard"
  description = "The offer type for the Cosmos DB account."
  type        = string
}

variable "enable_free_tier" {
  default     = true
  description = "Enable free tier for Cosmos DB account."
  type        = bool
}

variable "public_network_access_enabled" {
  default     = false
  description = "Whether or not public network access is allowed for the Cosmos DB account."
  type        = bool
}

variable "enable_multiple_write_locations" {
  default     = false
  description = "Whether or not multiple write locations are enabled for the Cosmos DB account."
  type        = bool
}

variable "enable_zone_redundancy_on_primary" {
  default     = false
  description = "Whether or not zone redundancy is enabled for the Cosmos DB account."
  type        = bool
}

variable "failover_locations" {
  default     = []
  description = "A list of failover locations for the Cosmos DB account."
  type        = list(map(string))
}

variable "consistency_policy_level" {
  description = "The consistency policy level for the Cosmos DB account."
  type        = string
}

variable "consistency_policy_max_interval_in_seconds" {
  default     = 5
  description = "The maximum consistency policy interval for the Cosmos DB account."
  type        = number
}

variable "consistency_policy_max_staleness_prefix" {
  default     = 100
  description = "The maximum consistency policy staleness prefix for the Cosmos DB account."
  type        = number
}

variable "capabilities" {
  default     = []
  description = "A list of capabilities for the Cosmos DB account."
  type        = list(string)
}

variable "is_virtual_network_filter_enabled" {
  default     = true
  description = "Whether or not virtual network filtering is enabled for the Cosmos DB account."
  type        = bool
}

variable "enable_automatic_failover" {
  default     = true
  description = "Whether or not automatic failover is enabled for the Cosmos DB account."
  type        = bool
}

variable "virtual_network_rule" {
  default     = []
  description = "A list of virtual network rules for the Cosmos DB account."
  type        = list(object({ id : string, ignore_missing_vnet_service_endpoint : bool }))
}

variable "backup_type" {
  default     = "Periodic"
  description = "The backup type for the Cosmos DB account."
  type        = string
}

variable "periodic_backup_interval" {
  default     = 60
  description = "The periodic backup interval for the Cosmos DB account."
  type        = number
}

variable "periodic_backup_retention_in_hours" {
  default     = 8
  description = "The periodic backup retention in hours for the Cosmos DB account."
  type        = number
}

variable "backup_storage_redundancy" {
  default     = "Geo"
  description = "The backup storage redundancy for the Cosmos DB account."
  type        = string
}

variable "analytical_storage_enabled" {
  default     = false
  description = "Enable Analytical Storage option for the Cosmos DB account"
  type        = bool
}

variable "ip_range_filter" {
  default     = null
  description = "A set of IP addresses or IP address ranges in CIDR form to be included as the allowed list of client IPs"
  type        = string
}
