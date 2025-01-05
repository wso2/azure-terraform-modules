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
  description = "Tags for the Log Alerts"
  type        = map(string)
}

variable "alert_enabled" {
  default     = true
  description = "Enable or disable the alert."
  type        = bool
}

variable "recommendation_alerts" {
  description = "Map of Azure recommendation alerts"
  type = map(object({
    alert_name              = string
    description             = string
    location                = string
    monitor_action_group_id = string
    recommendation_impact   = string
    scopes                  = list(string)
    webhook_properties      = map(string)
  }))
}

variable "activity_log_alerts" {
  description = "Map of Azure Activity Log alerts"
  type = map(object({
    alert_name              = string
    criteriaCategory        = string
    criteriaLevel           = string
    description             = string
    location                = string
    monitor_action_group_id = string
    scopes                  = list(string)
    webhook_properties      = map(string)
  }))
}

variable "resource_health_alerts" {
  description = "Map of Azure resource health alerts"
  type = map(object({
    alert_name              = string
    criteriaCategory        = string
    criteriaLevel           = string
    criteriaReason          = list(string)
    currentStatuses         = list(string)
    description             = string
    location                = string
    monitor_action_group_id = string
    previousStatuses        = list(string)
    query_enabled           = bool
    scopes                  = list(string)
    status                  = string
    target_resource_group   = string
    target_resource_id      = string
    target_resource_type    = string
    webhook_properties      = map(string)
  }))
}

variable "service_health_alerts" {
  description = "Map of Azure service health alerts"
  type = map(object({
    alert_name              = string
    criteriaCategory        = string
    criteriaLevel           = string
    description             = string
    location                = string
    monitor_action_group_id = string
    query_enabled           = bool
    scopes                  = list(string)
    targetEvents            = list(string)
    targetLocations         = list(string)
    webhook_properties      = map(string)
  }))
}

variable "specific_service_health_alerts" {
  description = "Map of Azure service health alerts"
  type = map(object({
    alert_name              = string
    criteriaCategory        = string
    description             = string
    location                = string
    monitor_action_group_id = string
    query_enabled           = bool
    scopes                  = list(string)
    targetEvents            = list(string)
    targetLocations         = list(string)
    targetServices          = list(string)
    webhook_properties      = map(string)
  }))
}

variable "monitor_activity_log_alert_abbreviation" {
  description = "The abbreviation of the resource name."
  type        = string
  default     = "ala"
}
