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

variable "route_table_firewall_egress_name" {
  description = "Name of the route table"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "tags" {
  description = "Tags for the resource"
  type        = map(string)
}

variable "subnet_id" {
  description = "ID of the subnet"
  type        = string
}

variable "firewall_private_ip" {
  description = "Private IP of the firewall"
  type        = string
}

variable "route_table_abbreviation" {
  description = "The abbreviation of the resource name."
  type        = string
  default     = "route"
}
