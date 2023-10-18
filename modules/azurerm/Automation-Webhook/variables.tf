
# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "resource_group_name" {
  type        = string
  description = "The resource group name"
}

variable "automation_webhook_name" {
  type        = string
  description = "The name of the Webhook"
}

variable "automation_account_name" {
  type        = string
  description = "The name of the automation account in which the Webhook is created"
}

variable "automation_webhook_expiry_time" {
  type        = string
  description = "Timestamp when the webhook expires"
}

variable "automation_webhook_enabled" {
  type        = bool
  description = "Controls if Webhook is enabled"
  default     = true
}

variable "automation_runbook_name" {
  type        = string
  description = "Name of the Automation Runbook to execute by Webhook"
  default     = true
}
