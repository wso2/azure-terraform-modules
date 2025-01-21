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

variable "scale_set_name" {
  description = "The name of the Linux Virtual Machine Scale Set."
  type        = string
}

variable "virtual_machine_scale_set_nic_name" {
  description = "The name of the Network Interface which should be attached to each Virtual Machine in the Scale Set."
  type        = string
}

variable "subnet_name" {
  description = "The virtual machine scaleset subnet name."
  type        = string
}

variable "virtual_machine_scale_set_network_security_group_name" {
  description = "The virtual machine scaleset network security group name."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group in which the Linux Virtual Machine Scale Set should be exist."
  type        = string
}

variable "location" {
  description = "The Azure location where the Linux Virtual Machine Scale Set should exist."
  type        = string
}

variable "sku" {
  description = "The Virtual Machine SKU for the Scale Set, such as Standard_F2."
  type        = string
}

variable "instances_count" {
  default     = 2
  description = "The number of Virtual Machines in the Scale Set."
  type        = number
}

variable "admin_username" {
  description = "The username of the local administrator on each Virtual Machine Scale Set instance."
  type        = string
}

variable "admin_ssh_public_key" {
  description = "The Public Key which should be used for authentication, which needs to be at least 2048-bit and in ssh-rsa format."
  type        = string
}

variable "source_image_id" {
  description = "The ID of an Image which each Virtual Machine in this Scale Set should be based on."
  type        = string
}

variable "network_interface_is_primary" {
  default     = true
  description = "Is this the Primary IP Configuration for this Network Interface?"
  type        = bool
}

variable "network_interface_ip_configuration_name" {
  default     = "internal"
  description = "The Name which should be used for this Network Interface."
  type        = string
}

variable "network_interface_ip_configuration_is_primary" {
  default     = true
  description = "Is this the Primary IP Configuration?"
  type        = bool
}

variable "virtual_network_name" {
  description = "The name of the virtual network to which to attach the subnet."
  type        = string
}

variable "subnet_address_prefixes" {
  description = "The address prefixes to use for the subnet."
  type        = list(string)
}

variable "tags" {
  description = "The tags."
  type        = map(string)
}

variable "enable_ama_agent" {
  default     = false
  description = "Specifies to enable Azure Monitoring Agent"
  type        = bool
}

variable "ama_type_handler_version" {
  default     = "1.0"
  description = "Specifies the version of the extension to use"
  type        = string
}

variable "ama_auto_upgrade_minor_version" {
  default     = true
  description = "Should the latest version of the Extension be used at Deployment Time, if one is available"
  type        = bool
}

variable "ama_automatic_upgrade_enabled" {
  default     = false
  description = "Should the Extension be automatically updated whenever the Publisher releases a new version of this VM Extension"
  type        = bool
}

variable "service_endpoints" {
  default     = null
  description = "The list of Service endpoints to associate with the subnet."
  type        = list(string)
}

variable "private_endpoint_network_policies" {
  default     = "Disabled"
  description = "Enable or Disable network policies for the private endpoint on the subnet. Possible values are Disabled, Enabled, NetworkSecurityGroupEnabled and RouteTableEnabled"
  type        = string
}

variable "force_deletion_enabled" {
  default     = false
  description = "Enable or disable force deletion of the virtual machine scale set instances"
  type        = bool
}

variable "scale_in_rule" {
  default     = "Default"
  description = "The scale in rule for the virtual machine scale set"
  type        = string
}

variable "os_disk_size_gb" {
  default     = 30
  description = "The size of the OS disk in GB"
  type        = number
}
