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

variable "automation_monthly_schedule_name" {
  description = "Specifies the name of the Schedule"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the Schedule is created"
  type        = string
}

variable "automation_account_name" {
  description = "The name of the automation account in which the Schedule is created"
  type        = string
}

variable "automation_monthly_schedule_frequency" {
  description = "The frequency of the schedule"
  type        = string
  default     = "Week"
}

variable "automation_monthly_schedule_intervel" {
  description = "The number of frequencys between runs"
  type        = string
}

variable "automation_monthly_schedule_start_time" {
  description = "Start time of the schedules"
  type        = string
}

variable "automation_monthly_schedule_description" {
  description = "A description for the schedule"
  type        = string
}

variable "automation_monthly_schedule_timezone" {
  description = "The timezone of the start time"
  type        = string
}

variable "automation_monthly_schedule_days" {
  description = "The days of the monthly the schedule should run"
  type        = list(string)
}
