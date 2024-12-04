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

variable "frontdoor_firewall_policy_abbreviation" {
  description = "Abbreviation for the FrontDoor Firewall Policy"
  default     = "fdfp"
  type        = string
}

variable "frontdoor_firewall_policy_name" {
  description = "Name for the FrontDoor Firewall Policy"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group in which the FrontDoor Firewall Policy should exist"
  type        = string
}

variable "sku_name" {
  description = "The SKU of the FrontDoor Firewall Policy"
  default     = "Premium_AzureFrontDoor"
  type        = string
}

variable "enabled" {
  description = "Is the FrontDoor Firewall Policy enabled?"
  default     = true
  type        = bool
}

variable "mode" {
  description = "The mode of the FrontDoor Firewall Policy"
  default     = "Prevention"
  type        = string
}

variable "redirect_url" {
  description = "The URL to redirect to when a request is blocked"
  type        = string
}

variable "custom_block_response_status_code" {
  description = "The status code to return when a request is blocked"
  default     = 403
  type        = number
}

variable "custom_block_response_body" {
  description = "The body to return when a request is blocked"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  default     = {}
  type        = map(string)
}

variable "custom_rules" {
  description = "A list of custom rules to apply to the FrontDoor Firewall Policy"
  default     = {}
  type = map(object({
    enabled                        = bool
    priority                       = number
    rate_limit_duration_in_minutes = number
    rate_limit_threshold           = number
    type                           = string
    action                         = string
    match_conditions = map(object({
      match_variable     = string
      operator           = string
      negation_condition = string
      match_values       = list(string)
      transforms         = list(string)
      selector           = string
    }))
  }))
}

variable "managed_rules" {
  description = "A list of managed rules to apply to the FrontDoor Firewall Policy"
  default     = {}
  type = map(object({
    type    = string
    version = string
    action  = string
    exclusions = list(object({
      match_variable = string
      operator       = string
      selector       = string
    }))
    overrides = list(object({
      rule_group_name = string
      exclusions = list(object({
        match_variable = string
        operator       = string
        selector       = string
      }))
      rules = list(object({
        rule_id = string
        action  = string
        enabled = bool
        exclusions = list(object({
          match_variable = string
          operator       = string
          selector       = string
        }))
      }))
    }))
  }))
}
