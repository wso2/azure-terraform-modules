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

variable "application_name" {
  type        = string
  description = "The name of the application."
}

variable "location" {
  type        = string
  description = "The Azure Region in which the CDN endpoint should be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the CDN endpoint."
}

variable "cdn_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
}

variable "cdn_sku_profile" {
  type        = string
  description = "The pricing related information of current CDN profile."
}

variable "project" {
  type        = string
  description = "The name of the project."
}

variable "environment" {
  type        = string
  description = "The name of the environment."
}

variable "padding" {
  type        = string
  description = "The padding to be used for the CDN endpoint."
}
