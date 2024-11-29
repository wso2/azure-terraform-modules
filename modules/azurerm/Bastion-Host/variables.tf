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

variable "bastion_host_name" {
  description = "The name of the Bastion Host."
  type        = string
}

variable "network_security_group_name" {
  description = "The name of the Network Security Group for the Bastion Host"
  type        = string
}

variable "public_ip_name" {
  description = "The name of the Public IP address for the Bastion Host"
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Bastion Host"
  type        = string
}

variable "copy_paste_enabled" {
  default     = true
  description = "Is Copy/Paste feature enabled for the Bastion Host"
  type        = bool
}

variable "file_copy_enabled" {
  default     = false
  description = "Is File Copy feature enabled for the Bastion Host"
  type        = bool
}

variable "ip_connect_enabled" {
  default     = false
  description = "Is IP Connect feature enabled for the Bastion Host"
  type        = bool
}

variable "shareable_link_enabled" {
  default     = false
  description = "Is Shareable Link feature enabled for the Bastion Host"
  type        = bool
}

variable "scale_units" {
  default     = 2
  description = "The number of scale units with which to provision the Bastion Host"
  type        = number
}

variable "tunneling_enabled" {
  default     = false
  description = "Is Tunneling feature enabled for the Bastion Host"
  type        = bool
}

variable "sku" {
  description = "The SKU of the Bastion Host. Accepted values are Basic and Standard"
  type        = string
}

variable "tags" {
  description = "The tags"
  type        = map(string)
}

variable "virtual_network_name" {
  description = "The Virtual Network name where the subnet of Bastion Host needs to be created"
  type        = string
}

variable "subnet_address_prefixes" {
  description = "Bastion host subnet address spaces"
  type        = string
}

variable "public_address_prefixes" {
  description = "Public address spaces allowed for the Bastion host subnet"
  type        = list(string)
}

variable "public_ip_zones" {
  default     = ["1", "2", "3"]
  description = "A collection containing the availability zone to allocate the Public IP in"
  type        = list(string)
}

variable "allow_https_internet_inbound" {
  default     = false
  description = "Specify whether to allow HTTPS Inbound internet traffic or not"
  type        = bool
}

variable "bastion_host_subnet_enforce_private_link_endpoint_network_policies" {
  default     = false
  description = "Enable or Disable network policies for the private link endpoint on the bastion host subnet"
  type        = bool
}

variable "bastion_host_abbreviation" {
  description = "The abbreviation of the resource name."
  type        = string
  default     = "bastion"
}

variable "bastion_subnet_name" {
  description = "The abbreviation of the resource name."
  type        = string
  default     = "AzureBastionSubnet"
}

variable "nsg_abbreviation" {
  description = "The abbreviation of the resource name."
  type        = string
  default     = "nsg-bastion-host"
}

variable "public_ip_abbreviation" {
  description = "The abbreviation of the resource name."
  type        = string
  default     = "pip"
}
