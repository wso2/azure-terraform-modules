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

variable "abbreviation" {
  description = "Abbreviation for the API Policy Fragment"
  type        = string
  default     = "api-policy-frag"
}

variable "name" {
  description = "Name of the API Policy Fragment"
  type        = string
}

variable "api_management_id" {
  description = "ID of the API Management Service where the API Policy Fragment is to be created."
  type        = string
}

variable "file_format" {
  description = "Format of the API Policy Fragment"
  type        = string
  default     = "xml"
}

variable "xml_template_file_path" {
  description = "The path to the policy XML template file"
  type        = string
}

variable "xml_template_vars" {
  description = "The variables to pass to the policy XML template"
  type        = any
  default     = {}
}
