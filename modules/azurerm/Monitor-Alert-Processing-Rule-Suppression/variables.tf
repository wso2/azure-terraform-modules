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

variable "location" {
  description = "Location Identifier for the Azure Region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "environment" {
  description = "Environment Name"
  type        = string
}

variable "project" {
  description = "Project Name"
  type        = string
}

variable "padding" {
  description = "Padding for the Resource"
  type        = number
}

variable "default_tags" {
  description = "Default Tags for the Resource"
  type        = map(string)
}

variable "start_time" {
  description = "Start Time for the rule schedule"
  type        = string
}

variable "end_time" {
  description = "End Time for the rule schedule"
  type        = string
}

variable "time_zone" {
  default     = "Sri Lanka Standard Time"
  description = "Time Zone for the rule schedule"
  type        = string
}

variable "scope" {
  description = "Scope for the rule"
  type        = string
}

variable "days_of_week" {
  description = "The days of the week the schedule should run"
  type        = list(string)
}
