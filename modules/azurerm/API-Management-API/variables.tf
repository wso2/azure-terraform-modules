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

variable "api_abbreviation" {
  description = "Abbreviation for the API Name"
  type        = string
  default     = "api"
}

variable "api_name" {
  description = "Name of the API"
  type        = string
}

variable "api_management_name" {
  description = "Name of the API Management Service where this API should be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the API Management API"
  type        = string
}

variable "api_revision" {
  description = "Revision number for the API"
  type        = string
  default     = "1"
}

variable "api_type" {
  description = "Type of the API. Possible values are graphql, http, soap, and websocket"
  type        = string
  default     = "http"
}

variable "display_name" {
  description = "Display name of the API"
  type        = string
}

variable "path" {
  description = "The Path for this API Management API, which is a relative URL which uniquely identifies this API and all of its resource paths within the API Management Service"
  type        = string
  default     = ""
}

variable "protocols" {
  description = "A list of protocols the operations in this API can be invoked. Possible values are http, https, ws, and wss"
  type        = list(string)
  default     = ["https"]
}

variable "backend_service_url" {
  description = "Absolute URL of the backend service which utilizes this API"
  type        = string
}

variable "subscription_required" {
  description = "Whether a subscription is required for the API"
  type        = bool
  default     = false
}

variable "xml_template_file_path" {
  description = "The path to the policy XML template file"
  type        = string
}

variable "xml_template_vars" {
  description = "The variables to pass to the policy XML template"
  type        = any
}
