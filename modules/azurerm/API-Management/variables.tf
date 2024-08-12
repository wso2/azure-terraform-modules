/*
 * Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com).
 *
 * WSO2 LLC. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

variable "api_management_abbreviation" {
  description = "Abbreviation for API Manager"
  type        = string
  default     = "apim"
}

variable "api_management_name" {
  description = "Name of the API Manager"
  type        = string
}

variable "location" {
  description = "Location of the API Manager instance"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the API Manager"
  type        = string
}

variable "sku_name" {
  description = "The Name of the SKU used for the API Manager"
  type        = string
}

variable "publisher_name" {
  description = "The name of the publisher"
  type        = string
}

variable "publisher_email" {
  description = "The email of the publisher"
  type        = string
}

variable "min_api_version" {
  description = "The minimum API version"
  type        = string
  default     = "2021-08-01"
}

variable "tags" {
  description = "Tags for the resource"
  type        = map(string)
}
