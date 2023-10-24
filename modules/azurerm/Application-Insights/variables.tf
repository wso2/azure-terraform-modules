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
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "application_type" {
  description = "Application type"
  type        = string
}

variable "daily_data_cap_in_gb" {
  description = "Daily data cap in GB"
  type        = string
}

variable "retention_in_days" {
  description = "Retention in days"
  type        = string
}

variable "default_tags" {
  description = "Default tags"
  type        = map(string)
}

variable "application_name" {
  description = "Application name"
  type        = string
}

variable "padding" {
  description = "Padding to differentiate between resources"
  type        = string
}

variable "disable_ip_masking" {
  default     = false
  description = "Disable IP masking"
  type        = bool
}

variable "daily_data_cap_notifications_disabled" {
  default     = false
  description = "Disable daily data cap notifications"
  type        = bool
}
