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

variable "rule_set_name" {
  description = "Name of the rule set"
  type        = string
}

variable "cdn_frontdoor_profile_id" {
  description = "The ID of the CDN Front Door Profile within which the Rule Set should be created"
  type        = string
}

variable "rules" {
  description = "Map of rules to be included in the Rule Set"
  type = map(object({
    order             = number
    behavior_on_match = optional(string)

    url_rewrite_actions = optional(list(object({
      source_pattern          = string
      destination             = string
      preserve_unmatched_path = optional(bool)
    })), [])

    url_redirect_actions = optional(list(object({
      redirect_type        = string
      destination_hostname = string
      redirect_protocol    = optional(string)
      destination_path     = optional(string)
      query_string         = optional(string)
      destination_fragment = optional(string)
    })), [])

    route_configuration_override_actions = optional(list(object({
      cache_duration                = optional(string)
      cdn_frontdoor_origin_group_id = optional(string)
      forwarding_protocol           = optional(string)
      query_string_caching_behavior = optional(string)
      query_string_parameters       = optional(list(string))
      compression_enabled           = optional(bool)
      cache_behavior                = optional(string)
    })), [])

    request_header_actions = optional(list(object({
      header_action = string
      header_name   = string
      value         = optional(string)
    })), [])

    response_header_actions = optional(list(object({
      header_action = string
      header_name   = string
      value         = optional(string)
    })), [])

    conditions = optional(map(object({
      type             = string
      match_values     = optional(list(string))
      operator         = optional(string)
      negate_condition = optional(bool)
      transforms       = optional(list(string))
      object_name      = optional(string)
    })), {})

  }))
}
