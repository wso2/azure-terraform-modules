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
  description = "Existing Private DNS Zone resource ID"
  type        = string
}

variable "private_dns_zone_vnet_link_name" {
  description = "VNet Link name for the Private DNS Zone"
  type        = string
}

variable "virtual_network_id" {
  description = "Existing Virtual Network ID"
  type        = string
}

variable "registration_enabled" {
  description = "Enable automatic registration of virtual network in the Private DNS Zone"
  type        = bool
}

variable "dns_resolution_policy" {
  default = "Default"
  description = "DNS resolution policy for the Private DNS Zone. This value can be 'Default' or 'NxDomainRedirect'"
  type        = string
}
