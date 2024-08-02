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

variable "api_management_abbreviation" {
  description = "Abbreviation for API Manager"
  type        = string
  default     = "apim"
}

variable "api_management_name" {
  description = "Name of the API Manager"
  type        = string
}

variable "location" {
  description = "Location of the API Manager instance"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the API Manager"
  type        = string
}

variable "sku_name" {
  description = "The Name of the SKU used for the API Manager"
  type        = string
}

variable "publisher_name" {
  description = "The name of the publisher"
  type        = string
}

variable "publisher_email" {
  description = "The email of the publisher"
  type        = string
}

variable "min_api_version" {
  description = "The minimum API version"
  type        = string
  default     = "2021-08-01"
}

variable "tags" {
  description = "Tags for the resource"
  type        = map(string)
}
