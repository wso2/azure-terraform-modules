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

variable "log_analytics_data_export_rule_name" {
  description = "The name of the Log Analytics Data Export Rule"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the Log Analytics Data Export should exist"
  type        = string
}

variable "workspace_resource_id" {
  description = "The resource ID of the workspace"
  type        = string
}

variable "destination_resource_id" {
  description = "The destination resource ID. It should be a storage account, an event hub namespace or an event hub."
  type        = string
}

variable "table_names" {
  default     = []
  description = "A list of table names to export to the destination resource"
  type        = list(any)
}

variable "log_analytics_data_export_rule_enabled" {
  default     = true
  description = "Is this Log Analytics Data Export Rule enabled? Possible values include true or false"
  type        = bool
}
