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

variable "custom_domain_name" {
  description = "The custom domain name."
  type        = string
}

variable "custom_domain_suffix" {
  description = "The custom domain suffix."
  type        = string
  default     = "custom-domain"
}

variable "cdn_frontdoor_profile_id" {
  description = "The ID of the CDN Front Door Profile."
  type        = string
}

variable "dns_zone_id" {
  description = "The ID of the DNS Zone."
  type        = string
}

variable "host_name" {
  description = "The host name of the custom domain."
  type        = string
}

variable "certificate_type" {
  description = "The type of the certificate."
  type        = string
}

variable "minimum_tls_version" {
  description = "The minimum TLS version."
  type        = string
  default     = "TLS12"
}

variable "cdn_frontdoor_secret_id" {
  description = "The ID of the CDN Front Door Secret."
  type        = string
}
