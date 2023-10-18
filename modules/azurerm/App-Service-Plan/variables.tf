# -------------------------------------------------------------------------------------
#
# Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "environment" {}
variable "project" {}
variable "application_name" {}
variable "padding" {}
variable "location" {}
variable "resource_group_name" {}
variable "tier" {}
variable "size" {}
variable "capacity" {}
variable "resource_abbreviation" {
  type    = string
  default = "asp"
}
variable "app_service_plan_kind" {
  type    = string
  default = "Linux"
}
variable "default_tags" {
  type    = map(string)
  default = {}
}
variable "per_site_scaling" {
  type    = bool
  default = false
}
variable "zrs_enabled" {
  type    = bool
  default = false
}
variable "reserved" {
  type    = bool
  default = true
}
