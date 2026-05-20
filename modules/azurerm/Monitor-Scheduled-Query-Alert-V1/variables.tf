# -------------------------------------------------------------------------------------
#
# Copyright (c) 2026, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
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

variable "location" {
  description = "The location where the Log Analytics Workspace should be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group"
  type        = string
}

variable "query_rules_alert" {
  description = "Map of query rules alert"
  type = map(object({
    action_group_id_list       = list(string)
    alert_name                 = string
    log_analytics_workspace_id = string
    description                = string
    query_enabled              = bool
    query                      = string
    severity                   = number
    frequency                  = number
    time_window                = number
    operator                   = string
    threshold                  = number
    metric_trigger_operator    = string
    metric_threshold           = number
    metric_trigger_type        = string
    metric_column              = string
    custom_webhook_payload     = optional(string)
  }))
}

variable "count_trigger_query_rules_alert" {
  description = "Map of count trigger query rules alert"
  type = map(object({
    action_group_id_list       = list(string)
    alert_name                 = string
    log_analytics_workspace_id = string
    description                = string
    query_enabled              = bool
    query                      = string
    severity                   = number
    frequency                  = number
    time_window                = number
    operator                   = string
    threshold                  = number
    custom_webhook_payload     = optional(string)
  }))
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "scheduled_query_alert_abbreviation" {
  description = "Abbreviation for the scheduled query alert name"
  type        = string
  default     = "sqra"
}
