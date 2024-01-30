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

variable "static_site_name" {
  type        = string
  description = "Name of the static site."
}

variable "location" {
  type        = string
  description = "Location of the resource deployment."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name where the resource will be deployed."
}

variable "sku_tier" {
  default     = "Free"
  type        = string
  description = "SKU tier which is used for the static site."
}

variable "sku_size" {
  default     = "Free"
  type        = string
  description = "SKU size which is used for the static site."
}

variable "identity_type" {
  default     = null
  type        = string
  description = "Static site identity type."
}

variable "identity_ids" {
  default     = null
  type        = list(string)
  description = "Static site identity IDs."
}

variable "tags" {
  default     = {}
  type        = map(string)
  description = "Tags for the resource."
}

variable "custom_domain_name" {
  default     = null
  type        = string
  description = "Custom domain name for the static site."
}

variable "custom_domain_validation_type" {
  default     = null
  type        = string
  description = "Custom domain validation type."
}
