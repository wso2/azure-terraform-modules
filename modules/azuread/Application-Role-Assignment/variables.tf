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

variable "application_name" {
  description = "The display name of the Azure AD application."
  type        = string
}

variable "description" {
  description = "The description of the Azure AD application."
  type        = string
}

variable "owners" {
  description = "A set of object ids of the owners of the Azure AD application."
  type        = set(string)
}

variable "role_assignments" {
  description = "A map of role assignments with scope and role definition name."
  type = map(object({
    scope                = string
    role_definition_name = string
  }))
  default = null
}

variable "required_resource_access_map" {
  description = "A map of resource_app_id to a map of resource_access objects."
  type        = map(map(string))
  default     = null
}

variable "custom_role_definitions" {
  description = "Map of custom role definitions"
  type = map(object({
    name        = string
    description = string
    permissions = list(string)
    scope       = string
  }))
  default = {}
}
