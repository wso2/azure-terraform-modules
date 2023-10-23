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

variable "project" {
  description = "The project name"
}
variable "environment" {
  description = "The enviroment"
}
variable "resource_group_name" {
  description = "The resource group name"
}
variable "location" {
  description = "The cloud region"
}
variable "automation_account_name" {
  description = "The azure automation account name"
}
variable "automation_runbook_name" {
  description = "The azure automation runbook name"
}
variable "uri" {
  description = "The URI od the external automation runbook"
}
variable "runbook_type" {
  default = "PowerShell"
}
variable "filepath" {
  description = "The local file path of the automation runbook"
}
variable "log_verbose" {
  description = "The log verbose boolean"
  default = true
}
variable "log_progress" {
  description = "The log progress boolean"
  default = true
}
variable "tags" {
  description = "The tags"
}
