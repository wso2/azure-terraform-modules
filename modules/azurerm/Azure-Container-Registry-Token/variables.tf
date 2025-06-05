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

variable "container_registry_name" {
  description = "The name of the Azure Container Registry Token."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the Azure Container Registry Token is created."
  type        = string
}

variable "actions" {
  description = "The actions that the Azure Container Registry Token can perform."
  type        = list(string)
}

variable "scope_map_name" {
  description = "The name of the scope map for the Azure Container Registry Token."
  type        = string
}

variable "project" {
  description = "The name of the project for which the Azure Container Registry Token is created."
  type        = string
}

variable "environment" {
  description = "The environment for which the Azure Container Registry Token is created."
  type        = string
}

variable "token_password_1_expiry" {
  description = "The expiry time for the first password of the Azure Container Registry Token."
  type        = string
  default     = null
}

variable "token_password_2_expiry" {
  description = "The expiry time for the second password of the Azure Container Registry Token."
  type        = string
  default     = null
}
