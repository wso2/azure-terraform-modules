# -------------------------------------------------------------------------------------
#
# Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------
variable "name" {
  description = "VMSS name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name."
  type        = string
}

variable "location" {
  description = "Location."
  type        = string
}

variable "sku" {
  description = "The Virtual Machine SKU for the Scale Set."
  type        = string
}

variable "instances" {
  description = "The number of Virtual Machines in the Scale Set. Defaults to 0."
  type        = number
  default     = 0
}

variable "admin_username" {
  description = "The username of the local administrator on each Virtual Machine Scale Set instance. Changing this forces a new resource to be created."
  type        = string
}

variable "tags" {
  description = "A mapping of tags which should be assigned to this Virtual Machine Scale Set."
  type        = map(string)
}

variable "admin_ssh_username" {
  description = "The Username for which this Public SSH Key should be configured."
  type        = string
}

variable "admin_ssh_public_key_path" {
  description = "The path of the Public Key which should be used for authentication, which needs to be at least 2048-bit and in ssh-rsa format."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the Subnet which this VMSS should be connected to."
  type        = string
}

variable "os_disk_storage_account_type" {
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values include Standard_LRS, StandardSSD_LRS, StandardSSD_ZRS, Premium_LRS and Premium_ZRS. Changing this forces a new resource to be created."
  default     = "Standard_LRS"
  type        = string
}

variable "os_disk_caching" {
  description = "The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite."
  default     = "ReadWrite"
  type        = string
}

variable "os_disk_size_gb" {
  description = "The size of the OS Disk which should be created."
  default     = 30
  type        = number
}

variable "nic_name" {
  description = "The Name which should be used for this Network Interface. Changing this forces a new resource to be created."
  type        = string
}

variable "nic_network_security_group_id" {
  description = "The ID of a Network Security Group which should be assigned to this Network Interface."
  type        = string
  default     = null
}

variable "application_gateway_backend_address_pool_ids" {
  description = "A list of Backend Address Pools ID's from a Application Gateway which this Virtual Machine Scale Set should be connected to."
  type        = list(string)
  default     = []
}

variable "load_balancer_backend_address_pool_ids" {
  description = "A list of Backend Address Pools ID's from a Load Balancer which this Virtual Machine Scale Set should be connected to."
  type        = list(string)
  default     = []
}

variable "source_image_id" {
  description = "The ID of an Image which each Virtual Machine in this Scale Set should be based on. Possible Image ID types include Image ID, Shared Image ID, Shared Image Version ID, Community Gallery Image ID, Community Gallery Image Version ID, Shared Gallery Image ID and Shared Gallery Image Version ID."
  default     = null
  type        = string
}

variable "source_image_reference" {
  description = "VM image reference. One of either source_image_id or source_image_reference must be set."
  type        = map(string)
}

variable "zone_balance" {
  description = "Should the Virtual Machines in this Scale Set be strictly evenly distributed across Availability Zones? Defaults to false. Changing this forces a new resource to be created."
  default     = false
  type        = bool
}

variable "zones" {
  description = "Specifies a list of Availability Zones in which this Linux Virtual Machine Scale Set should be located. Changing this forces a new Linux Virtual Machine Scale Set to be created."
  default     = []
  type        = list(string)
}

variable "upgrade_mode" {
  description = "Specifies how Upgrades (e.g. changing the Image/SKU) should be performed to Virtual Machine Instances. Possible values are Automatic, Manual and Rolling. Defaults to Manual. Changing this forces a new resource to be created."
  default     = "Manual"
  type        = string
}

variable "health_probe_id" {
  description = "The ID of a Load Balancer Probe which should be used to determine the health of an instance. This is Required and can only be specified when upgrade_mode is set to Automatic or Rolling"
  default     = null
  type        = string
}

variable "rolling_upgrade_policy" {
  description = <<EOD
VM image reference. One of either source_image_id or source_image_reference must be set.
Map should contain the following keys and respective values:
  - cross_zone_upgrades_enabled: A boolean value (bool)
  - max_batch_instance_percent: A numeric value representing the maximum percentage of instances (number)
  - max_unhealthy_instance_percent: A numeric value representing the maximum percentage of unhealthy instances (number)
  - max_unhealthy_upgraded_instance_percent: A numeric value representing the maximum percentage of unhealthy upgraded instances (number)
  - pause_time_between_batches: Time interval between batches as a string (string)
EOD
  type        = map(string)
  default     = {}
}
