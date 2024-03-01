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

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "tags" {
  description = "Tags for the resource group"
  type        = map(string)
}

variable "location" {
  description = "Location of the resource group"
  type        = string
}

variable "alert_enabled" {
  default     = true
  description = "Enable or disable the alert."
  type        = bool
}

variable "metric_alerts_with_2_dimensions" {
  description = "Map of Azure metric alerts with 2 dimensions"
  type = map(object({
    scopes                    = list(string)
    alert_name                = string
    description               = string
    monitor_action_group_id   = string
    frequency                 = string
    window_size               = string
    severity                  = string
    target_resource_type      = string
    criteria_metric_namespace = string
    criteria_metric_name      = string
    criteria_aggregation      = string
    criteria_operator         = string
    criteria_threshold        = number
    dimension_1_name          = string
    dimension_1_operator      = string
    dimension_1_values        = list(string)
    dimension_2_name          = string
    dimension_2_operator      = string
    dimension_2_values        = list(string)
  }))
}

variable "metric_alerts_with_1_dimension" {
  description = "Map of Azure metric alerts with 1 dimensions"
  type = map(object({
    scopes                    = list(string)
    alert_name                = string
    description               = string
    monitor_action_group_id   = string
    frequency                 = string
    window_size               = string
    severity                  = string
    target_resource_type      = string
    criteria_metric_namespace = string
    criteria_metric_name      = string
    criteria_aggregation      = string
    criteria_operator         = string
    criteria_threshold        = number
    dimension_1_name          = string
    dimension_1_operator      = string
    dimension_1_values        = list(string)
  }))
}

variable "metric_alerts" {
  description = "Map of Azure metric alerts"
  type = map(object({
    scopes                    = list(string)
    alert_name                = string
    description               = string
    monitor_action_group_id   = string
    frequency                 = string
    window_size               = string
    severity                  = string
    target_resource_type      = string
    criteria_metric_namespace = string
    criteria_metric_name      = string
    criteria_aggregation      = string
    criteria_operator         = string
    criteria_threshold        = number
  }))
}

variable "monitor_metric_alert_abbreviation" {
  description = "The abbreviation of the resource name."
  type        = string
  default     = "ma"
}
