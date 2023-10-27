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
  description = "The location of the resource need to be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the vm is created in."
  type        = string
}

variable "environment" {
  description = "The name of the environment. Eg: dev"
  type        = string
}

variable "project" {
  description = "The name of the project. Eg: asgardeo"
  type        = string
}

variable "application_name" {
  description = "The name of the application."
  type        = string
}

variable "padding" {
  description = "The padding value."
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
}

variable "subnet_id" {
  description = "Id of the subnet which VM is going to be created"
  type        = string
}

variable "source_image_id" {
  description = "The ID of an Image which each virtual machine should be based on."
  type        = string
}

variable "enable_ama_agent" {
  default     = false
  description = "Specifies to enable Azure Monitoring Agent"
  type        = bool
}
