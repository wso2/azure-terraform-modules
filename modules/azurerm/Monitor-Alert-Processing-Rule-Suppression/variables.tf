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
  type        = string
  description = "Location Identifier for the Azure Region"
}
variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group"
}
variable "environment" {
  type        = string
  description = "Environment Name"
}
variable "project" {
  type        = string
  description = "Project Name"
}
variable "padding" {
  type        = number
  description = "Padding for the Resource"
}
variable "default_tags" {
  type        = map(string)
  description = "Default Tags for the Resource"
}
variable "start_time" {
  type        = string
  description = "Start Time for the rule schedule"
}
variable "end_time" {
  type        = string
  description = "End Time for the rule schedule"
}
variable "time_zone" {
  type        = string
  description = "Time Zone for the rule schedule"
  default     = "Sri Lanka Standard Time"
}
variable "scope" {
  type        = string
  description = "Scope for the rule"
}
variable "days_of_week" {
  description = "The days of the week the schedule should run"
  type        = list(string)
}
