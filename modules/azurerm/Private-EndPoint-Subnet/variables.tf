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

variable "network_security_group_name" {
  description = "The name of the network security group for the private endpoint subnet."
  type        = string
}

variable "private_endpoint_subnet_name" {
  description = "The name of the private endpoint subnet."
  type        = string
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  type        = string
}

variable "private_endpoint_subnet_route_table_name" {
  description = "The name of the route table for the private endpoint subnet."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual network."
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "address_prefixes" {
  description = "The address prefixes to use for the virtual network."
  type        = string
}

variable "tags" {
  description = "Tags for the virtual network."
  type        = map(string)
}

variable "private_endpoint_subnet_enforce_private_link_endpoint_network_policies" {
  default     = false
  description = "Enable or Disable network policies for the private link endpoint on the private endpoint subnet"
  type        = bool
}
