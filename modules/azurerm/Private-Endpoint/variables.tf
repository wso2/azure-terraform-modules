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
variable "private_endpoint_subnet_id" {
  type = string
}
variable "location" {}
variable "resource_group_name" {}
variable "private_connection_resource_id" {}
variable "private_dns_zone_ids" {
  type = list(string)
}
variable "subresource_names" {
  type = list(string)
}
variable "tags" {}

variable "project" {
  type = string
}

variable "workload_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "padding" {
  type = string
}
