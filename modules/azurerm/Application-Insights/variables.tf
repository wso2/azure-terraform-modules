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

variable "project" {}
variable "environment" {}
variable "location" {}
variable "resource_group_name" {}
variable "application_type" {}
variable "daily_data_cap_in_gb" {}
variable "retention_in_days" {}
variable "default_tags" {}
variable "application_name" {
  type = string
}
variable "padding" {
  type = string
}

variable "disable_ip_masking" {
  default = "false"
}

variable "daily_data_cap_notifications_disabled" {
  default = "false"
}
