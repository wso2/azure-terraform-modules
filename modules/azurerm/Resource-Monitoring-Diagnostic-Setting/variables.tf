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

variable "log_setting_name" {
  description = "Name of the Diagnostic Setting"
  type        = string
}

variable "target_resource_id" {
  description = "Azure resource ID for target resource to extract logs"
  type        = string
}

variable "archival_locations" {
  default = {
    archival_storage_account_id = "",
    log_analytics_workspace_id  = ""
  }
  description = "Locations to extract Log files to keep empty if not required"
  type = object({
    archival_storage_account_id = string,
    log_analytics_workspace_id  = string
  })
  validation {
    condition     = var.archival_locations.archival_storage_account_id != "" || var.archival_locations.log_analytics_workspace_id != ""
    error_message = "Please specify at least one locations to send Logs."
  }
}

variable "sub_service_id" {
  default     = ""
  description = "Path to access Sub service (OPTIONAL)"
  type        = string
}

variable "required_metric_categories" {
  default     = []
  description = "Metrics to be extracted from the resource"
  type = list(object(
    {
      category_name : string,
      retention_period : number
    }
  ))
}

variable "required_log_categories" {
  default     = []
  description = "Logs to be extracted from the resource"
  type = list(object(
    {
      category_name : string,
      retention_period : number
    }
  ))
}

variable "all_log_types_enabled" {
  default     = { enabled : false, retention_period : 0 }
  description = "Allow or Disallow all log types to be extracted from the resource"
  type = object({
    enabled : bool,
    retention_period : number
  })
}

variable "all_metrics_enabled" {
  default     = { enabled : false, retention_period : 0 }
  description = "Allow or Disallow all metrics to be extracted from the resource"
  type = object({
    enabled : bool,
    retention_period : number
  })
}

variable "log_analytics_destination_type" {
  default     = null
  description = "Destination type for Log Analytics Workspace"
  type        = string
}
