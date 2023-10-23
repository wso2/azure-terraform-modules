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

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group in which the Linux Virtual Machine Scale Set should be exist."
}
variable "location" {
  type        = string
  description = "The Azure location where the Linux Virtual Machine Scale Set should exist."
}
variable "sku" {
  type        = string
  description = "The Virtual Machine SKU for the Scale Set, such as Standard_F2."
}
variable "padding" {
  type        = string
  description = "The padding value."
}
variable "name" {
  type        = string
  description = "The name of the Linux Virtual Machine Scale Set."
}

variable "instances_count" {
  type        = number
  default     = 2
  description = "The number of Virtual Machines in the Scale Set."
}

variable "admin_username" {
  type        = string
  description = "The username of the local administrator on each Virtual Machine Scale Set instance."
}

variable "admin_ssh_public_key" {
  type        = string
  description = "The Public Key which should be used for authentication, which needs to be at least 2048-bit and in ssh-rsa format."
}

variable "source_image_id" {
  type        = string
  description = "The ID of an Image which each Virtual Machine in this Scale Set should be based on."
}

variable "network_interface_is_primary" {
  type        = bool
  default     = true
  description = "Is this the Primary IP Configuration for this Network Interface?"
}

variable "network_interface_ip_configuration_name" {
  type        = string
  default     = "internal"
  description = "The Name which should be used for this Network Interface."
}

variable "network_interface_ip_configuration_is_primary" {
  type        = bool
  default     = true
  description = "Is this the Primary IP Configuration?"
}

variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network to which to attach the subnet."
}

variable "subnet_address_prefixes" {
  type        = list(string)
  description = "The address prefixes to use for the subnet."
}

variable "project" {
  type        = string
  description = "The name of the project. Eg: asgardeo"
}

variable "environment" {
  type        = string
  description = "The name of the environment. Eg: dev"
}

variable "tags" {
  type        = map(string)
  description = "The default tags."
}

variable "enable_ama_agent" {
  type        = bool
  description = "Specifies to enable Azure Monitoring Agent"
  default     = false
}

variable "ama_type_handler_version" {
  type        = string
  description = "Specifies the version of the extension to use"
  default     = "1.0"
}

variable "ama_auto_upgrade_minor_version" {
  type        = bool
  description = "Should the latest version of the Extension be used at Deployment Time, if one is available"
  default     = true
}

variable "ama_automatic_upgrade_enabled" {
  type        = bool
  description = "Should the Extension be automatically updated whenever the Publisher releases a new version of this VM Extension"
  default     = false
}

variable "service_endpoints" {
  description = "The list of Service endpoints to associate with the subnet."
  type        = list(string)
  default     = null
}
