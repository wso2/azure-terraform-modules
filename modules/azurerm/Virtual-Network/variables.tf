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

variable "location" {}
variable "padding" {}
variable "virtual_network_address_space" {}
variable "resource_group_name" {}
variable "environment" {}
variable "project" {}
variable "application_name" {}
variable "network_mode" {
  default = ""
}
variable "default_tags" {}
variable "private_dns_zones" {
  description = "Private DNS zone map"
  type        = list(map(string))
  default     = []
}
variable "ddos_protection_plan_id" { default = "" }
variable "ddos_protection_plan_enable" { default = false }
