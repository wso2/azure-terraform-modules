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

variable "route_name" {
  description = "The name of the route."
  type        = string
}

variable "cdn_frontdoor_endpoint_id" {
  description = "The ID of the Front Door Endpoint."
  type        = string
}

variable "cdn_frontdoor_origin_group_id" {
  description = "The ID of the Front Door Origin Group."
  type        = string
}

variable "cdn_frontdoor_origin_ids" {
  description = "The IDs of the Front Door Origins."
  type        = list(string)
}

variable "cdn_frontdoor_rule_set_ids" {
  description = "The IDs of the Front Door Rule Sets."
  type        = list(string)
}

variable "enable_route" {
  description = "Is the route enabled?"
  type        = bool
  default     = true
}

variable "forwarding_protocol" {
  description = "The protocol to use for forwarding traffic."
  type        = string
  default     = "HttpsOnly"
}

variable "https_redirect_enabled" {
  description = "Is HTTPS redirect enabled?"
  type        = bool
  default     = false
}

variable "patterns_to_match" {
  description = "The patterns to match for the route."
  type        = list(string)
  default     = ["/*"]
}

variable "supported_protocols" {
  description = "The supported protocols for the route."
  type        = list(string)
  default     = ["Https"]
}

variable "cdn_frontdoor_custom_domain_ids" {
  description = "The IDs of the Front Door Custom Domains."
  type        = list(string)
}

variable "link_to_default_domain" {
  description = "Link to the default domain?"
  type        = bool
  default     = false
}

variable "cdn_frontdoor_origin_path" {
  description = "The path to the Front Door Origin."
  type        = string
}

variable "enable_cache" {
  description = "Is caching enabled?"
  type        = bool
  default     = false
}

variable "cache_query_string_caching_behavior" {
  description = "The query string caching behavior."
  type        = string
  default     = "IgnoreQueryString"
}

variable "cache_query_strings" {
  description = "The query strings to cache."
  type        = list(string)
  default     = []
}

variable "cache_compression_enabled" {
  description = "Is compression enabled?"
  type        = bool
  default     = false
}

variable "cache_content_types_to_compress" {
  description = "The content types to compress."
  type        = list(string)
  default     = []
}
