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

variable "app_configuration_abbreviation" {
  description = "The abbreviation of the App Configuration."
  type        = string
  default     = "appconfig"
}

variable "app_configuration_name" {
  description = "The name of the App Configuration."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the App Configuration should be created."
  type        = string
}

variable "location" {
  description = "The location/region where the App Configuration should be created."
  type        = string
}

variable "local_auth_enabled" {
  description = "Is local authentication enabled for the App Configuration."
  type        = bool
  default     = false
}

variable "public_network_access" {
  description = "The public network access for the App Configuration."
  type        = string
  default     = "Enabled"
}

variable "purge_protection_enabled" {
  description = "Is purge protection enabled for the App Configuration."
  type        = bool
  default     = false
}

variable "sku" {
  description = "The SKU of the App Configuration."
  type        = string
  default     = "free"
}

variable "soft_delete_retention_days" {
  description = "The number of days to retain deleted configuration values."
  type        = number
  default     = 7
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "replicas" {
  description = "A list of replicas for the App Configuration."
  type = list(object({
    name     = string
    location = string
  }))
  default = []
}

variable "configuration_keys" {
  description = "A list of configuration keys for the App Configuration."
  type = map(object({
    key          = string
    label        = string
    content_type = string
    value        = string
    locked       = bool
    type         = string
    tags         = map(string)
  }))
  default = {}
}
