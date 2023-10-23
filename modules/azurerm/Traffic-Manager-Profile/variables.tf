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

variable "routing_method" {
  default = "Performance"
}
variable "resource_group_name" {}
variable "environment" {}
variable "project" {}
variable "ttl" {
  type = number
}
variable "endpoint_monitoring_protocol" {
  type    = string
  default = "https"
}
variable "default_tags" {
  default = {}
}
variable "health_check_path" {}
variable "health_check_interval" {
  description = "Health Check frequency in seconds"
  default     = 30
  type        = number
}
variable "health_check_timeout" {
  description = "Health Check timeout in seconds"
  default     = 10
  type        = number
}
variable "tolerated_failures" {
  description = "Number of consecutive failures to deem as degraded"
  default     = 3
  type        = number
}
variable "traffic_view_enabled" {
  type    = bool
  default = false
}

variable "location" {
  description = "The Azure region to deploy"
  type        = string
}

variable "padding" {
  description = "Padding for the deployment"
  type        = string
}
