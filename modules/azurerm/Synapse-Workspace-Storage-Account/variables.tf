# -------------------------------------------------------------------------------------
#
# Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com).
#
# WSO2 LLC. licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#
# --------------------------------------------------------------------------------------

variable "name" {
  description = "The name of the Synapse Workspace"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Synapse Workspace"
  type        = string
}

variable "location" {
  description = "The Azure location where the Synapse Workspace should be created"
  type        = string
}

variable "sql_administrator_login" {
  description = "The username of the SQL Administrator"
  type        = string
}

variable "sql_administrator_login_password" {
  description = "The password of the SQL Administrator"
  type        = string
  sensitive   = true
}

variable "managed_virtual_network_enabled" {
  description = "Enable or disable Managed Virtual Network for the Synapse Workspace"
  type        = bool
  default     = false
}

variable "data_exfiltration_protection_enabled" {
  description = "Enable or disable data exfiltration protection"
  type        = bool
  default     = false
}

variable "storage_account_name" {
  description = "The name of the Storage account linked to the Synapse Workspace"
  type        = string
}

variable "account_tier" {
  description = "The tier of the storage account"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "The replication type of the storage account"
  type        = string
  default     = "LRS"
}

variable "account_kind" {
  description = "The kind of storage account"
  type        = string
  default     = "StorageV2"
}

variable "is_hns_enabled" {
  description = "Enable or disable Hierarchical Namespace"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "fw_start_ip_address" {
  description = "The starting IP address of the firewall rule"
  type        = string
  default     = "0.0.0.0"
}

variable "fw_end_ip_address" {
  description = "The ending IP address of the firewall rule"
  type        = string
  default     = "0.0.0.0"
}

variable "fw_rule_name" {
  description = "The name of the firewall rule for the Synapse workspace"
  type        = string
  default     = "AllowAllWindowsAzureIps"
}

variable "synapse_linked_service_type" {
  description = "The type of linked service for the Synapse workspace"
  type        = string
  default     = "AzureBlobStorage"
}

variable "cross_tenant_replication_enabled" {
  description = "Enable or disable cross tenant replication"
  type        = bool
  default     = false
}

variable "connection_string" {
  description = "Resource Connection String (Cosmos DB, Storage Account, Data Lake)"
  type        = string
  default     = null
}
