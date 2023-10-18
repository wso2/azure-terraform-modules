# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "resource_group_name" {
  description = "Resource group name"
  type = string
}
variable "firewall_name" {
  description = "Firewall name"
  type = string
}
variable "application_name" {
  description = "Application name"
  type = string
}
variable "shortened_project" {
  description = "Project name"
  type = string
}
variable "shortened_environment" {
  description = "Environment"
  type = string
}
variable "shortened_location" {
  description = "Location"
  type = string
}
variable "shortened_padding" {
  description = "Padding"
  type = string
}
variable "priority" {
  description = "Priority"
  type = number
}
variable "action" {
  description = "Name of the action"
  type = string
  default = "Allow"
}

variable "network_rules" {
  description = "Map of Network rules"
  type = map(object({
    name = string
    source_addresses = list(string)
    destination_ports = list(string)
    destination_addresses = list(string)
    protocols = list(string)
  }))
}
