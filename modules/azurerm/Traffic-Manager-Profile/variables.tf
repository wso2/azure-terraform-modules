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
  default     = "Performance"
  description = "The routing method of the Traffic Manager Profile."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Traffic Manager Profile."
  type        = string
}

variable "traffic_manager_profile_dns_config_relative_name" {
  description = "The relative DNS name of the Traffic Manager Profile."
  type        = string
}

variable "traffic_manager_profile_name" {
  description = "The name of the Traffic Manager Profile."
  type        = string
}

variable "ttl" {
  description = "The Time-To-Live (TTL), in seconds."
  type        = number
}

variable "endpoint_monitoring_protocol" {
  default     = "https"
  description = "value for endpoint_monitoring_protocol"
  type        = string
}

variable "tags" {
  default     = {}
  description = "Tags for the resource"
  type        = map(string)
}

variable "health_check_path" {
  description = "Health Check path"
  type        = string
}

variable "health_check_interval" {
  default     = 30
  description = "Health Check frequency in seconds"
  type        = number
}

variable "health_check_timeout" {
  default     = 10
  description = "Health Check timeout in seconds"
  type        = number
}

variable "tolerated_failures" {
  default     = 3
  description = "Number of consecutive failures to deem as degraded"
  type        = number
}

variable "traffic_view_enabled" {
  default     = false
  description = "Enable or Disable traffic view for the Traffic Manager Profile"
  type        = bool
}

variable "expected_status_code_ranges" {
  default     = []
  description = "A list of status code ranges in the format of 100-101"
  type        = list(string)
}

variable "max_return" {
  default     = 8
  description = "The maximum number of endpoints to be returned in DNS queries."
  type        = number
}
