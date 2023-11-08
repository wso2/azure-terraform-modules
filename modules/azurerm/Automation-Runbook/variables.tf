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

variable "automation_runbook_name" {
  description = "The azure automation runbook name"
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name"
  type        = string
}

variable "location" {
  description = "The cloud region"
  type        = string
}

variable "automation_account_name" {
  description = "The azure automation account name"
  type        = string
}

variable "automation_runbook_name" {
  description = "The azure automation runbook name"
  type        = string
}

variable "uri" {
  description = "The URI od the external automation runbook"
  type        = string
}

variable "runbook_type" {
  default     = "PowerShell"
  description = "The runbook type"
  type        = string
}

variable "filepath" {
  description = "The local file path of the automation runbook"
  type        = string
}

variable "log_verbose" {
  default     = true
  description = "The log verbose boolean"
  type        = bool
}

variable "log_progress" {
  default     = true
  description = "The log progress boolean"
  type        = bool
}

variable "tags" {
  description = "The tags"
  type        = map(string)
}
