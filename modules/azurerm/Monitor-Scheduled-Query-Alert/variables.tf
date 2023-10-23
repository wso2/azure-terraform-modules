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

variable "location" {}
variable "resource_group_name" {}
variable "environment" {}
variable "padding" {}
variable "project" {}
variable "query_rules_alert" {
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
