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
  description = "A list of rules to be included in the Rule Set"
  type = map(object({
    order             = number
    behavior_on_match = string

    url_rewrite_actions = list(object({
      source_pattern          = string
      destination             = string
      preserve_unmatched_path = bool
    }))

    url_redirect_actions = list(object({
      redirect_type        = string
      destination_hostname = string
      redirect_protocol    = string
      destination_path     = string
      query_string         = string
      destination_fragment = string
    }))

    route_configuration_override_actions = list(object({
      cache_duration                = number
      cdn_frontdoor_origin_group_id = string
      forwarding_protocol           = string
      query_string_caching_behavior = string
      query_string_parameters       = list(string)
      compression_enabled           = bool
      cache_behavior                = string
    }))

    request_header_actions = list(object({
      header_action = string
      header_name   = string
      value         = string
    }))

    response_header_actions = list(object({
      header_action = string
      header_name   = string
      value         = string
    }))

    conditions = map(object({
      type             = string
      match_values     = list(string)
      operator         = string
      negate_condition = bool
      transforms       = list(string)
      object_name      = string
    }))

  }))
}
