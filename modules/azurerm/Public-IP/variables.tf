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

variable "project" {
  description = "value of the project"
  type        = string
}

variable "environment" {
  description = "value of the environment"
  type        = string
}

variable "location" {
  description = "The Azure Region."
  type        = string
}

variable "application_name" {
  description = "The name of the application."
  type        = string
}

variable "padding" {
  description = "The padding."
  type        = string
}

variable "tags" {
  description = "Tags for the virtual network."
  type        = map(string)
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual network."
  type        = string
}

variable "sku" {
  default     = "Standard"
  description = "The SKU of the Public IP."
  type        = string
}

variable "idle_timeout_in_minutes" {
  default     = "4"
  description = "The idle timeout in minutes."
  type        = string
}

variable "ip_version" {
  default     = "IPv4"
  description = "The IP Version."
  type        = string
}

variable "allocation_method" {
  default     = "Static"
  description = "The allocation method."
  type        = string
}
