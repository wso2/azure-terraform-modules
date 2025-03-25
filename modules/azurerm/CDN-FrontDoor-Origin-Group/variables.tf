# -------------------------------------------------------------------------------------
#
# Copyright (c) 2024, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
#
# WSO2 LLC. licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the
# specific language governing permissions and limitations
# under the License.
#
# --------------------------------------------------------------------------------------

variable "origin_group_name" {
  description = "Name of the origin group"
  type        = string
}

variable "origin_group_suffix" {
  description = "Suffix of the origin group"
  type        = string
  default     = "origin-group"
}

variable "cdn_frontdoor_profile_id" {
  description = "The ID of the CDN Front Door Profile within which the Origin Group should be created"
  type        = string
}

variable "enable_session_affinity" {
  description = "Should session affinity be enabled for this Origin Group?"
  type        = bool
  default     = false
}

variable "time_to_restore_traffic_to_new_or_healed_endpoints_in_minutes" {
  description = "The time in minutes to restore traffic to a new or healed endpoint"
  type        = number
  default     = 5
}

variable "enable_health_probe" {
  description = "Should health probes be enabled for this Origin Group?"
  type        = bool
  default     = false
}

variable "health_probe_check_interval_in_seconds" {
  description = "The interval in seconds between health probes"
  type        = number
  default     = 30
}

variable "health_probe_path" {
  description = "The path to use for health probes"
  type        = string
  default     = "/"
}

variable "health_probe_protocol" {
  description = "The protocol to use for health probes"
  type        = string
  default     = "Https"
}

variable "health_probe_request_type" {
  description = "The request type to use for health probes"
  type        = string
  default     = "HEAD"
}

variable "load_balancing_additional_latency_in_milliseconds" {
  description = "The additional latency in milliseconds to add to the load balancing algorithm"
  type        = number
  default     = 0
}

variable "load_balancing_sample_size" {
  description = "The number of samples to take for load balancing"
  type        = number
  default     = 4
}

variable "load_balancing_successful_samples_required" {
  description = "The number of successful samples required for load balancing"
  type        = number
  default     = 2
}

variable "public_origins" {
  description = "A map of public origins to create within the Origin Group"
  type = map(object({
    enabled            = bool
    check_cert         = bool
    host_name          = string
    http_port          = number
    https_port         = number
    origin_host_header = string
    priority           = number
    weight             = number
  }))
  default = {}
}

variable "private_link_origins" {
  description = "A map of private link origins to create within the Origin Group"
  type = map(object({
    enabled                  = bool
    host_name                = string
    origin_host_header       = string
    priority                 = number
    weight                   = number
    private_link_target_type = string
    private_link_location    = string
    private_link_target_id   = string
  }))
  default = {}
}

variable "private_link_service_origins" {
  description = "A map of private link service origins to create within the Origin Group"
  type = map(object({
    enabled                = bool
    host_name              = string
    origin_host_header     = string
    priority               = number
    weight                 = number
    private_link_location  = string
    private_link_target_id = string
  }))
  default = {}
}
