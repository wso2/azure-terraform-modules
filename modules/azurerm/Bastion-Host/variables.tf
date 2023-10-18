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
  type        = string
  description = "Specifies the supported Azure location where the resource exists"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Bastion Host"
}

variable "environment" {
  type        = string
  description = "The environment"
}

variable "project" {
  type        = string
  description = "The project"
}

variable "application_name" {
  type        = string
  description = "The name of the Bastion Host. Changing this forces a new resource to be created"
}

variable "padding" {
  type        = string
  description = "The padding"
}

variable "copy_paste_enabled" {
  type        = bool
  default     = true
  description = "Is Copy/Paste feature enabled for the Bastion Host"
}

variable "file_copy_enabled" {
  type        = bool
  default     = false
  description = "Is File Copy feature enabled for the Bastion Host"
}

variable "ip_connect_enabled" {
  type        = bool
  default     = false
  description = "Is IP Connect feature enabled for the Bastion Host"
}

variable "shareable_link_enabled" {
  type        = bool
  default     = false
  description = "Is Shareable Link feature enabled for the Bastion Host"
}

variable "scale_units" {
  type        = number
  default     = 2
  description = "The number of scale units with which to provision the Bastion Host"
}

variable "tunneling_enabled" {
  type        = bool
  default     = false
  description = "Is Tunneling feature enabled for the Bastion Host"
}

variable "sku" {
  type        = string
  description = "The SKU of the Bastion Host. Accepted values are Basic and Standard"
}

variable "default_tags" {
  type        = map(string)
  description = "The default tags"
}

variable "virtual_network_name" {
  type        = string
  description = "The Virtual Network name where the subnet of Bastion Host needs to be created"
}

variable "subnet_address_prefixes" {
  type        = string
  description = "Bastion host subnet address spaces"
}

variable "public_address_prefixes" {
  type        = list(string)
  description = "Public address spaces allowed for the Bastion host subnet"
}

variable "public_ip_zones" {
  type        = list(string)
  default     = ["1", "2", "3"]
  description = "A collection containing the availability zone to allocate the Public IP in"
}

variable "allow_https_internet_inbound" {
  type        = bool
  default     = true
  description = "Specify whether to allow HTTPS Inbound internet traffic or not"
}
