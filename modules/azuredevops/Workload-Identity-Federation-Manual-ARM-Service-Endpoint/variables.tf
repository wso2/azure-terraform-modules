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

variable "service_endpoint_name" {
  description = "The name of the service endpoint."
  type        = string
}

variable "project_id" {
  description = "The ID of the project."
  type        = string
}

variable "description" {
  description = "The description of the service endpoint."
  type        = string
}

variable "service_principal_id" {
  description = "The service principal application Id."
  type        = string
}

variable "tenant_id" {
  description = "The Tenant ID if the service principal."
  type        = string
}

variable "subscription_id" {
  description = "The Subscription ID of the Azure targets."
  type        = string
}

variable "subscription_name" {
  description = "The Subscription Name of the targets."
  type        = string
}
