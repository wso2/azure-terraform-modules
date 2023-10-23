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

variable "environment" {}
variable "project" {}
variable "application_name" {}
variable "location" {}
variable "resource_group_name" {}

variable "default_tags" {
  type    = map(string)
  default = {}
}
variable "kind" {
  default = "GlobalDocumentDB"
}
variable "offer_type" {
  default = "Standard"
}
variable "enable_free_tier" {
  type    = bool
  default = true
}

variable "public_network_access_enabled" {
  type    = bool
  default = false
}
variable "enable_multiple_write_locations" {
  type    = bool
  default = true
}
variable "enable_zone_redundancy_on_primary" {
  type    = bool
  default = false
}
variable "failover_locations" {
  type    = list(map(string))
  default = []
}
variable "consistency_policy_level" {}
variable "consistency_policy_max_interval_in_seconds" {
  type    = number
  default = 5
}
variable "consistency_policy_max_staleness_prefix" {
  type    = number
  default = 100
}
variable "capabilities" {
  type    = list(string)
  default = []
}
variable "is_virtual_network_filter_enabled" {
  type    = bool
  default = true
}
variable "enable_automatic_failover" {
  type    = bool
  default = true
}
variable "virtual_network_rule" {
  type    = list(object({ id : string, ignore_missing_vnet_service_endpoint : bool }))
  default = []
}
variable "backup_type" {
  default = "Periodic"
}
variable "periodic_backup_interval" {
  type    = number
  default = 60
}
variable "periodic_backup_retention_in_hours" {
  type    = number
  default = 8
}
