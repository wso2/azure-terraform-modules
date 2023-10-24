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
  type        = string
  description = "Name of the project in which this service will be used."
}

variable "application_name" {
  type        = string
  description = "Name of the application."
}

variable "environment" {
  type        = string
  description = "Name of the project environment where the service will be deployed."
}

variable "padding" {
  type        = string
  description = "Padding for resource naming."
}

variable "location" {
  type        = string
  description = "Location of the resource deployment."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name where the resource will be deployed."
}

variable "os_type" {
  type        = string
  description = "OS type of the service plan."
  default     = "Linux"
}

variable "sku_name" {
  type        = string
  description = "SKU name which is used for the service plan."
}

variable "availability_zone_enabled" {
  type        = bool
  description = "Whether the availability zone is enabled or not."
}

variable "maximum_elastic_worker_count" {
  type        = number
  description = "Maximum elastic worker count when scaling out."
  default     = null
}

variable "worker_count" {
  type        = number
  description = "Number of worker node to be in the service plan."
}

variable "default_tags" {
  type        = map(string)
  description = "Tags for the resource."
  default     = {}
}
