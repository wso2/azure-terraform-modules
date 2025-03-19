# -------------------------------------------------------------------------------------
#
# Copyright (c) 2025, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
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

variable "private_dns_zone_id" {
  type        = string
  description = "Existing Private DNS Zone resource ID"
}

variable "private_dns_zone_vnet_link_name" {
  type        = string
  description = "VNet Link name for the Private DNS Zone"
}

variable "virtual_network_id" {
  type        = string
  description = "Existing Virtual Network ID"
}

variable "registration_enabled" {
  type        = bool
  description = "Enable automatic registration of virtual network in the Private DNS Zone"
}

variable "dns_resolution_policy" {
  type        = string
  description = "DNS resolution policy for the Private DNS Zone"
}
