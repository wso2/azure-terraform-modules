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

variable "prefix_length" {
  description = "The prefix length of the Public IP Prefix."
  type        = number
}

variable "tags" {
  description = "Tags for the Public IP Prefix."
  type        = map(string)
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Public IP Prefix."
  type        = string
}

variable "sku" {
  default     = "Standard"
  description = "The SKU of the Public IP Prefix."
  type        = string
}

variable "ip_version" {
  default     = "IPv4"
  description = "The IP version of the Public IP Prefix."
  type        = string
}

variable "application_name" {
  description = "Application name of the public ip prefix"
  type        = string
}

variable "padding" {
  description = "Padding"
  type        = string
}
