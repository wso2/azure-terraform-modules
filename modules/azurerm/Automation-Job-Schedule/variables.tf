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
  description = "The name of the resource group in which the job schedule is created"
  type        = string
}

variable "automation_account_name" {
  description = "The name of the automation account in which the job schedule is created"
  type        = string
}

variable "automation_schedule_name" {
  description = "The name of the automation job schedule"
  type        = string
}

variable "automation_runbook_name" {
  description = "The name of a runbook to link to a schedule"
  type        = string
}

variable "worker_group_run_on" {
  description = "Name of a hybrid worker group the runbook will be executed on"
  type        = string
}

variable "automation_runbook_parameters" {
  description = "Parameter list of the runbook"
  type        = map(string)
}
