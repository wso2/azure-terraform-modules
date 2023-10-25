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
  description = "Name of the resource group."
  type        = string
}

variable "tags" {
  description = "Map of tags."
  type        = map(string)
}

variable "environment" {
  description = "Name of the environment."
  type        = string
}

variable "padding" {
  description = "The padding value."
  type        = string
}

variable "project" {
  description = "Name of the project."
  type        = string
}

variable "alert_enabled" {
  default     = true
  description = "Enable or disable the alert."
  type        = bool
}

variable "activity_log_administrative_alerts" {
  description = "Map of azure activity log administrative alerts"
  type = map(object({
    scopes                  = list(string)
    reason                  = string
    description             = string
    monitor_action_group_id = string
    category                = string
    operation_name          = string
    resource_id             = string
  }))
}
