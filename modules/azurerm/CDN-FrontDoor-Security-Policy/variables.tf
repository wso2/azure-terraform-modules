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

variable "security_policy_name" {
  description = "The name of the CDN FrontDoor Security Policy"
  type        = string
}

variable "cdn_frontdoor_profile_id" {
  description = "The ID of the CDN FrontDoor Profile to associate the Security Policy with"
  type        = string
}

variable "cdn_frontdoor_firewall_policy_id" {
  description = "The ID of the CDN FrontDoor Firewall Policy to associate with the Security Policy"
  type        = string
}

variable "patterns_to_match" {
  description = "The patterns to match for the Security Policy"
  default     = ["/*"]
  type        = list(string)
}

variable "domains" {
  description = "The domains to associate with the Security Policy"
  default     = {}
  type        = map(string)
}
