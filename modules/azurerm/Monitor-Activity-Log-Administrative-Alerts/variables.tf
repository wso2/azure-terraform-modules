# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "default_tags" {
  type        = map(string)
  description = "Map of default tags."
}

variable "environment" {
  type        = string
  description = "Name of the environment."
}

variable "padding" {
  type        = string
  description = "The padding value."
}

variable "project" {
  type        = string
  description = "Name of the project."
}

variable "alert_enabled" {
  type = bool
  default = true
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
