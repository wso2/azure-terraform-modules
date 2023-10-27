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

variable "environment" {
  description = "The name of the environment"
  type        = string
}

variable "padding" {
  description = "Padding for the deployment"
  type        = string
}

variable "project" {
  description = "The name of the project"
  type        = string
}

variable "query_rules_alert" {
  description = "Map of query rules alert"
  type = map(object({
    action_group_id_list       = list(string)
    reason                     = string
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
  }))
}

variable "count_trigger_query_rules_alert" {
  description = "Map of count trigger query rules alert"
  type = map(object({
    action_group_id_list       = list(string)
    reason                     = string
    log_analytics_workspace_id = string
    description                = string
    query_enabled              = bool
    query                      = string
    severity                   = number
    frequency                  = number
    time_window                = number
    operator                   = string
    threshold                  = number
  }))
}
