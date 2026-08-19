# -------------------------------------------------------------------------------------
#
# Copyright (c) 2026, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
#
# WSO2 LLC. licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the
# specific language governing permissions and limitations
# under the License.
#
# --------------------------------------------------------------------------------------

variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
}

variable "computer_name" {
  description = "The computer name of the virtual machine."
  type        = string
}

variable "os_disk_name" {
  description = "The name of the OS disk."
  type        = string
}

variable "nic_name" {
  description = "Virtual machine network interface name."
  type        = string
}

variable "nic_ip_configuration_name" {
  description = "Virtual machine network interface ip configuration name."
  type        = string
}

variable "location" {
  description = "The location of the resource need to be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the vm is created in."
  type        = string
}

variable "size" {
  description = "The VM size that need to be created"
  type        = string
}

variable "os_disk_size_gb" {
  description = "The OS disk size of the VM"
  type        = string
}

variable "admin_username" {
  description = "The admin username of the VM"
  type        = string
}

variable "public_key_path" {
  description = "The VM public key path"
  type        = string
}

variable "tags" {
  description = "Default tag list"
  type        = map(string)
  default = {}
}

variable "subnet_id" {
  description = "Id of the subnet which VM is going to be created"
  type        = string
}

variable "source_image_id" {
  description = "The ID of an Image which each virtual machine should be based on."
  type        = string
  default     = "Ubuntu Server 24.04 LTS"
}

variable "enable_ama_agent" {
  default     = false
  description = "Specifies to enable Azure Monitoring Agent"
  type        = bool
}

variable "vm_abbreviation" {
  description = "The abbreviation of the resource name."
  type        = string
  default     = "vm"
}

variable "computer_abbreviation" {
  description = "The abbreviation of the resource name."
  type        = string
  default     = "vm"
}

variable "os_disk_abbreviation" {
  description = "The abbreviation of the resource name."
  type        = string
  default     = "osdisk"
}

variable "nic_abbreviation" {
  description = "The abbreviation of the resource name."
  type        = string
  default     = "nic"
}

variable "nic_ip_configuration_abbreviation" {
  description = "The abbreviation of the resource name."
  type        = string
  default     = "nic"
}

variable "public_ip_address_id" {
  description = "The ID of the public IP address to associate with the network interface."
  type        = string
}

variable "os_disk_storage_account_type" {
  description = "Storage account type for OS disk"
  type        = string
  default     = "Standard_LRS"
}

variable "os_disk_caching" {
  description = "caching for OS disk"
  type        = string
  default     = "ReadWrite"
}