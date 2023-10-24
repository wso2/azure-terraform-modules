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
  description = "The name of the application."
  type        = string
}

variable "location" {
  description = "The Azure Region in which the CDN endpoint should be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the CDN endpoint."
  type        = string
}

variable "cdne_tags" {
  description = "A mapping of tags to assign to the resource."
  type        = string
}

variable "origin_name" {
  description = "The name of the origin."
  type        = string
}

variable "project" {
  description = "The name of the project."
  type        = string
}

variable "environment" {
  description = "The name of the environment."
  type        = string
}

variable "padding" {
  description = "The padding to be used for the CDN endpoint."
  type        = string
}

variable "cdn_delivery_rules" {
  description = "CDN Delivery URL Path Rules"
  type = map(object({
    name            = string
    order           = number
    match_condition = list(string)
    operator        = string
    protocol        = string
    hostname        = string
    path            = string
    redirect_type   = string
  }))
}

variable "cdn_profile_name" {
  description = "The CDN Profile to which to attach the CDN Endpoint."
  type        = string
}

variable "origin_host_header" {
  description = "The origin host header that CDN provider will send along with content requests to origins."
  type        = string
}

variable "querystring_caching_behaviour" {
  description = "The query string caching behavior. Valid values are IgnoreQueryString, BypassCaching, and UseQueryString."
  type        = string
}

variable "origin_host_name" {
  description = "A string that determines the hostname/IP address of the origin server."
  type        = string
}
