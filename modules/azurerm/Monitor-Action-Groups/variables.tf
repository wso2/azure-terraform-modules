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

variable "resource_group_name" {}
variable "default_tags" {}
variable "environment" {}
variable "short_name" {}
variable "severity" {}
variable "padding" {}
variable "project" {}
variable "email_receivers" {
  description = "List of email receivers for the action group"
  type = list(object({
    name                    = string
    email_address           = string
    use_common_alert_schema = bool
  }))
}

variable "actions_webhook_critical" {
  type = list(object({
    name                    = string
    service_uri             = string
    use_common_alert_schema = bool
  }))
}

variable "automation_runbooks" {
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
