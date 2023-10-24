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
variable "endpoint_name" {
  type        = string
  description = "Name of the endpoint"
}
variable "profile_id" {
  type        = string
  description = "ID of the traffic manager profile"
}
variable "priority" {
  type        = number
  description = "Priority"
}
variable "target" {
  type        = string
  description = "Target IP or FQDN DNS name"
}
variable "header_name" {
  type        = string
  description = "Name of the custom header"
}
variable "header_value" {
  type        = string
  description = "Value of the custom header"
}
variable "enabled" {
  default     = true
  type        = bool
  description = "Is the endpoint enabled"
}
