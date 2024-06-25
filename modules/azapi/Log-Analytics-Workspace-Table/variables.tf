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

variable "resource_name" {
  description = "The name of the Log Analytics Workspace Table Resource"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics Workspace ID"
  type        = string
}

variable "ingestion_plan" {
  description = "Instruct the system how to handle and charge the logs ingested to this table. Possible values are Basic or Analytics."
  type        = string
}

variable "retention_in_days" {
  description = "The table retention in days, between 4 and 730. Setting this property to -1 will default to the workspace retention."
  type        = number
  default     = -1
}

variable "columns" {
  description = "A list of table custom columns."
  type = list(object({
    name        = string
    type        = string
    description = string
  }))
}

variable "table_name" {
  description = "The name of the table."
  type        = string
}

variable "total_retention_in_days" {
  description = "The table total retention in days, between 4 and 2555. Setting this property to -1 will default to table retention."
  type        = number
  default     = -1
}
