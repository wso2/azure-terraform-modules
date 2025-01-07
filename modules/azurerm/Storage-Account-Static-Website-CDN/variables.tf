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

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}

variable "location" {
  description = "Azure location where the resource exists"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which the EventHub Namespace exists"
  type        = string
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account"
  type        = string
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account"
  type        = string
}

variable "tags" {
  description = "Tags to be used in resources"
  type        = map(string)
}

variable "index_document" {
  description = "The name of the index document."
  type        = string
}

variable "error_document" {
  description = "The name of the error document."
  type        = string
}

variable "network_rules_ip_whitelist" {
  default     = []
  description = "List of IP addresses or ranges to whitelist for storage account via firewall. Defaults to []"
  type        = list(string)
}

variable "network_rules_default_action" {
  default     = "Deny"
  description = "The default action of allow or deny when no other rules match"
  type        = string
}

variable "network_rules_subnet_ids" {
  default     = []
  description = "List of subnet IDs to whitelist for storage account via firewall. Defaults to []"
  type        = list(string)
}

variable "allow_nested_items_to_be_public" {
  default     = false
  description = "Allow or disallow nested items within this Account to opt into being public"
  type        = bool
}

variable "network_rules_bypass" {
  default     = []
  description = "List of actions that bypass the network rule. Defaults to []"
  type        = list(string)
}

variable "cdn_profile_name" {
  description = "Name of the CDN profile"
  type        = string
}

variable "cdn_profile_sku" {
  description = "The pricing tier of the CDN profile"
  type        = string
}

variable "cdn_endpoint_name" {
  description = "Name of the CDN endpoint"
  type        = string
}

variable "cdn_origin_name" {
  description = "Name of the CDN origin"
  type        = string
}

variable "cdn_delivery_rules" {
  description = "List of delivery rules for the CDN endpoint"
  type = map(object({
    hostname         = string
    match_conditions = list(string)
    operator         = string
    order            = number
    path             = string
    protocol         = string
    redirect_type    = string
    name             = string
  }))
}
