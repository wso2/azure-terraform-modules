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
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Name of the environment"
  type        = string
}

variable "location" {
  description = "The Azure Region."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the EventHub Namespace."
  type        = string
}

variable "capacity" {
  description = "Specifies the Capacity / Throughput Units for the EventHub Namespace."
  type        = number
}

variable "maximum_throughput_units" {
  description = "Specifies the Maximum Throughput Units for the EventHub Namespace."
  type        = number
}

variable "network_rules" {
  description = "Network rules restricing access to the event hub."
  type        = object({ ip_rules = list(string), subnet_ids = list(string) })
}

variable "tags" {
  description = "Tags for the EventHub Namespace."
  type        = map(string)
}

variable "application_name" {
  description = "Name of the application"
  type        = string
}

variable "padding" {
  description = "Padding for the resource name"
  type        = string
}

variable "public_network_access_enabled" {
  default     = "Allow"
  description = "Is public network access enabled for the EventHub Namespace?"
  type        = string
}
