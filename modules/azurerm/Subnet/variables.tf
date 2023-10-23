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

variable "application_name" {
  description = "The name of the application."
  type        = string
}
variable "project" {
  description = "The name of the project. Eg: asgardeo"
  type        = string
}
variable "environment" {
  description = "The name of the environment. Eg: dev"
  type        = string
}
variable "location" {
  description = "The location of the resource need to be created."
  type        = string
}
variable "padding" {
  description = "The padding value."
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group in which the subnet is created in."
  type        = string
}
variable "virtual_network_name" {
  description = "The name of the virtual network in which the subnet is created in."
  type        = string
}
variable "address_prefix" {
  description = "The address prefix for the subnet. Eg: 10.0.0.0/28"
  type        = list(string)
  default     = null
}
variable "service_endpoints" {
  description = "The list of Service endpoints to associate with the subnet."
  type        = list(string)
  default     = null
}
variable "default_tags" {
  description = "The default tags."
  type        = map(string)
}
variable "enforce_private_link_service_network_policies" {
  description = "Enable or Disable network policies for the private link service on the subnet"
  type = bool
  default = false
}
variable "enforce_private_link_endpoint_network_policies" {
  description = "Enable or Disable network policies for the private link endpoint on the subnet"
  type = bool
  default = false
}

variable "delegation" {
  description = "Delegation for the subnet."
  type = list(object({
    delegation_name = string,
    service_delegation_name = string,
    service_delegation_actions = list(string)
  }))
  default     = null
}
