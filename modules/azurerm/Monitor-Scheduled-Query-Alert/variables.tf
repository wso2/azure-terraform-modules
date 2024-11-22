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
    action_group_id_list    = list(string)
    alert_name              = string
    scope_list              = list(string)
    description             = string
    query_enabled           = bool
    query                   = string
    severity                = number
    evaluation_frequency    = string
    window_duration         = string
    operator                = string
    threshold               = number
    time_aggregation_method = string
    dimension = list(object({
      name     = string
      operator = string
      values   = list(string)
    }))
    failing_periods = list(object({
      minimum_failing_periods_to_trigger_alert = number
      number_of_evaluation_periods             = number
    }))
    metric_measure_column = string
  }))
}

variable "count_trigger_query_rules_alert" {
  description = "Map of count trigger query rules alert"
  type = map(object({
    action_group_id_list = list(string)
    alert_name           = string
    scope_list           = list(string)
    description          = string
    query_enabled        = bool
    query                = string
    severity             = number
    evaluation_frequency = string
    window_duration      = string
    operator             = string
    threshold            = number
  }))
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
