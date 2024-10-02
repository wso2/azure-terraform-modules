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
  description = "The resource group name"
  type        = string
}

variable "automation_webhook_name" {
  description = "The name of the Webhook"
  type        = string
}

variable "automation_account_name" {
  description = "The name of the automation account in which the Webhook is created"
  type        = string
}

variable "automation_webhook_expiry_time" {
  description = "Timestamp when the webhook expires"
  type        = string
  default     = null
}

variable "automation_webhook_enabled" {
  default     = true
  description = "Controls if Webhook is enabled"
  type        = bool
}

variable "automation_runbook_name" {
  default     = true
  description = "Name of the Automation Runbook to execute by Webhook"
  type        = string
}

variable "notification_time_in_months" {
  description = "The time in months to notify before the webhook expires"
  type        = number
  default     = 1
}

variable "rotation_time_in_months" {
  description = "The time in months to rotate the webhook"
  type        = number
  default     = 6
}
