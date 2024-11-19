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

variable "storage_data_lake_gen2_filesystem_id" {
  description = "The ID of the Data Lake Storage Gen2 Filesystem to be used by the Synapse Workspace"
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

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
