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
    type = string
    description = "The location of the resource need to be created."
}

variable "resource_group_name" {
    type = string
    description = "The name of the resource group in which the vm is created in."
}

variable "environment" {
    type = string
    description = "The name of the environment. Eg: dev"
}

variable "project" {
    type = string
    description = "The name of the project. Eg: asgardeo"
}

variable "application_name" {
    type = string
    description = "The name of the application."
}

variable "padding" {
    type = string
    description = "The padding value."
}

variable "virtual_network_name" {
    type = string
    description = "The name of the virtual network to be created"
}

variable "size" {
    type = string
    description = "The VM size that need to be created"
}

variable "os_disk_size_gb" {
    type = string
    description = "The OS disk size of the VM"
}

variable "admin_username" {
    type = string
    description = "The admin username of the VM"
}

variable "public_key_path" {
    type = string
    description = "The VM public key path"
}

variable "default_tags" {
    type    = map(string)
    description = "Default tag list"
}

variable "subnet_id" {
    type = string
    description = "Id of the subnet which VM is going to be created"
}

variable "source_image_id" {
  type        = string
  description = "The ID of an Image which each virtual machine should be based on."
}

variable "enable_ama_agent" {
  type        = bool
  description = "Specifies to enable Azure Monitoring Agent"
  default     = false
}
