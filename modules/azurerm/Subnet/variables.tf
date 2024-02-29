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

variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
}

variable "network_security_group_name" {
  description = "The name of the network security group."
  type        = string
}

variable "location" {
  description = "The location of the resource need to be created."
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
  default     = null
  description = "The address prefix for the subnet. Eg: 10.0.0.0/28"
  type        = list(string)
}

variable "service_endpoints" {
  default     = null
  description = "The list of Service endpoints to associate with the subnet."
  type        = list(string)
}

variable "tags" {
  description = "The tags."
  type        = map(string)
}

variable "enforce_private_link_service_network_policies" {
  default     = false
  description = "Enable or Disable network policies for the private link service on the subnet"
  type        = bool
}

variable "enforce_private_link_endpoint_network_policies" {
  default     = false
  description = "Enable or Disable network policies for the private link endpoint on the subnet"
  type        = bool
}

variable "delegation" {
  default     = []
  description = "Delegation for the subnet."
  type = list(object({
    delegation_name            = string,
    service_delegation_name    = string,
    service_delegation_actions = list(string)
  }))
}

variable "network_security_group_name_abbreviation" {
  description = "The abbreviation of the resource name."
  type        = string
  default     = "nsg"
}

variable "subnet_name_abbreviation" {
  description = "The abbreviation of the resource name."
  type        = string
  default     = "snet"
}
