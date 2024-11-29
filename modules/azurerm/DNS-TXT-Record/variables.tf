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

variable "name" {
  description = "The name of the TXT record."
  type        = string
}

variable "dns_zone_name" {
  description = "The name of the DNS zone in which the record should be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the DNS zone exists."
  type        = string
}

variable "ttl" {
  description = "The Time To Live (TTL) of the DNS record in seconds."
  default     = 3600
  type        = number
}

variable "txt_record" {
  description = "The value of the TXT record."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}
