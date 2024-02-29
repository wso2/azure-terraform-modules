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
  description = "The Azure Region in which all resources in this example should be created."
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "virtual_network_address_space" {
  description = "The address space that is used the virtual network."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual network."
  type        = string
}

variable "tags" {
  description = "Tags to be used in resources"
  type        = map(string)
}

variable "private_dns_zones" {
  default     = []
  description = "Private DNS zone map"
  type        = list(map(string))
}

variable "ddos_protection_plan_id" {
  default     = ""
  description = "The ID of the DDoS protection plan to associate with the public IP address."
  type        = string
}

variable "ddos_protection_plan_enable" {
  default     = false
  description = "Enable DDoS protection plan"
  type        = bool
}

variable "private_dns_zone_name_abbreviation" {
  description = "The abbreviation of the resource name."
  type        = string
  default     = "pvtdnsvnl"
}

variable "virtual_network_name_abbreviation" {
  description = "The abbreviation of the resource name."
  type        = string
  default     = "vnet"
}
