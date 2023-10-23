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
  type        =  string
  description = "Resource group name where the resource will be deployed."
}

variable "sku_tier" {
  type        = string
  description = "SKU tier which is used for the static site."
  default     = "Free"
}

variable "sku_size" {
  type        = string
  description = "SKU size which is used for the static site."
  default     = "Free"
}

variable "identity_type" {
  type        = string
  description = "Static site identity type."
  default     = null
}

variable "identity_ids" {
  type        = list(string)
  description = "Static site identity IDs."
  default     = null
}

variable "default_tags" {
  type        = map(string)
  description = "Tags for the resource."
  default     = {}
}

variable "custom_domain_name" {
  type        = string
  description = "Custom domain name for the static site."
  default     = null
}

variable "custom_domain_validation_type" {
  type        = string
  description = "Custom domain validation type."
  default     = null
}