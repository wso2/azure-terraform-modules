# -------------------------------------------------------------------------------------
#
# Copyright (c) 2024, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
#
# WSO2 LLC. licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the
# specific language governing permissions and limitations
# under the License.
#
# --------------------------------------------------------------------------------------

variable "log_setting_name" {
  type        = string
  description = "Diagnostic Setting Name"
}

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
      category_name : string
    }
  ))
  description = "Metrics to be extracted from the resource"
  default     = []
}

variable "required_log_categories" {
  type = list(object(
    {
      category_name : string
    }
  ))
  description = "Logs to be extracted from the resource"
  default     = []
}

variable "all_log_types_enabled" {
  type        = bool
  description = "Allow or Disallow all log types to be extracted from the resource"
  default     = false
}

variable "all_metrics_enabled" {
  type        = bool
  description = "Allow or Disallow all metrics to be extracted from the resource"
  default     = false
}

variable "log_analytics_destination_type" {
  type        = string
  description = "Possible values are AzureDiagnostics and Dedicated. When set to Dedicated, logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy AzureDiagnostics table."
  default     = null
}
