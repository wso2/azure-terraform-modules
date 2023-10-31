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
  description = "Resource group name"
  type        = string
}

variable "tags" {
  description = "Tags for the Action Group."
  type        = map(string)
}

variable "environment" {
  description = "value of the environment"
  type        = string
}

variable "short_name" {
  description = "Short name"
  type        = string
}

variable "severity" {
  description = "Severity"
  type        = string
}

variable "padding" {
  description = "value of the padding"
  type        = string
}

variable "project" {
  description = "value of the project"
  type        = string
}

variable "email_receivers" {
  description = "List of email receivers for the action group"
  type = list(object({
    name                    = string
    email_address           = string
    use_common_alert_schema = bool
  }))
}

variable "actions_webhook_critical" {
  description = "List of webhook receivers for the action group"
  type = list(object({
    name                    = string
    service_uri             = string
    use_common_alert_schema = bool
  }))
}

variable "automation_runbooks" {
  default     = []
  description = "List of automation runbooks for the action group"
  type = list(object({
    name                    = string
    automation_account_id   = string
    runbook_name            = string
    webhook_resource_id     = string
    is_global_runbook       = bool
    service_uri             = string
    use_common_alert_schema = bool
  }))
}
