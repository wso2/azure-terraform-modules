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

variable "log_setting_name" {}

variable "target_resource_id" {
  type        = string
  description = "Azure resource ID for target resource to extract logs"
}

variable "archival_locations" {
  type = object({
    archival_storage_account_id = string,
    log_analytics_workspace_id  = string
  })
  description = "Locations to extract Log files to keep empty if not required"
  default = {
    archival_storage_account_id = "",
    log_analytics_workspace_id  = ""
  }
  validation {
    condition     = var.archival_locations.archival_storage_account_id != "" || var.archival_locations.log_analytics_workspace_id != ""
    error_message = "Please specify at least one locations to send Logs."
  }
}

variable "sub_service_id" {
  type        = string
  description = "Path to access Sub service (OPTIONAL)"
  default     = ""
}

variable "required_metric_categories" {
  type = list(object(
    {
      category_name : string,
      retention_period : number
    }
  ))
  description = "Metrics to be extracted from the resource"
  default     = []
}

variable "required_log_categories" {
  type = list(object(
    {
      category_name : string,
      retention_period : number
    }
  ))
  description = "Logs to be extracted from the resource"
  default     = []
}

variable "all_log_types_enabled" {
  type = object({
    enabled : bool,
    retention_period : number
  })
  default     = { enabled : false, retention_period : 0 }
  description = "Allow or Disallow all log types to be extracted from the resource"
}

variable "all_metrics_enabled" {
  type = object({
    enabled : bool,
    retention_period : number
  })
  default     = { enabled : false, retention_period : 0 }
  description = "Allow or Disallow all metrics to be extracted from the resource"
}

variable "log_analytics_destination_type" {
  default = null
}
