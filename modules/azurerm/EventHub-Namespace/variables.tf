# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 LLC. (https://www.wso2.com). All Rights Reserved.
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
variable "capacity" {}
variable "maximum_throughput_units" {}
variable "network_rules" {
  description = "Network rules restricing access to the event hub."
  type        = object({ ip_rules = list(string), subnet_ids = list(string) })
}
variable "default_tags" {}

variable "application_name" {
  type = string
}

variable "padding" {
  type = string
}

variable "public_network_access_enabled" {
  type = string
  description = "Is public network access enabled for the EventHub Namespace?"
  default = "Allow"
}
