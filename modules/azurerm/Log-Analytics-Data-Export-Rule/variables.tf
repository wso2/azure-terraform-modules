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

variable "log_analytics_data_export_rule_name" {
  type = string
  description = "The name of the Log Analytics Data Export Rule"
}
variable "resource_group_name" {
  type = string
  description = "The name of the Resource Group where the Log Analytics Data Export should exist"
}
variable "workspace_resource_id" {
  type = string
  description = "The resource ID of the workspace"
}
variable "destination_resource_id" {
  type = string
  description = "The destination resource ID. It should be a storage account, an event hub namespace or an event hub."
}
variable "table_names" {
  type = list
  description = "A list of table names to export to the destination resource"
  default = []
}
variable "log_analytics_data_export_rule_enabled" {
  type = bool
  description = "Is this Log Analytics Data Export Rule enabled? Possible values include true or false"
  default = true
}
