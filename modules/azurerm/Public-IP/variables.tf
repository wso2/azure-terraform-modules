# -------------------------------------------------------------------------------------
#
# Copyright (c) 2020, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "project" {}
variable "environment" {}
variable "location" {}
variable "application_name" {}
variable "padding" {}
variable "default_tags" {}
variable "resource_group_name" {}
variable "sku" {
  default = "Standard"
}
variable "idle_timeout_in_minutes" {
  default = "4"
}
variable "ip_version" {
  default = "IPv4"
}
variable "allocation_method" {
  default = "Static"
}
