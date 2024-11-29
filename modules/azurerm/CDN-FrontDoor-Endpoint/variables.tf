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

variable "frontdoor_endpoint_abbreviation" {
  description = "The abbreviation of the Front Door Endpoint."
  type        = string
  default     = "fe"
}

variable "frontdoor_endpoint_name" {
  description = "The name of the Front Door Endpoint."
  type        = string
}

variable "cdn_frontdoor_profile_id" {
  description = "The ID of the CDN Front Door Profile."
  type        = string
}

variable "enabled" {
  description = "Is the CDN Front Door Endpoint enabled?"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
