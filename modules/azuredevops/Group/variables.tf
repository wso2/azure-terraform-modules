# -------------------------------------------------------------------------------------
#
# Copyright (c) 2026, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
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

variable "scope" {
  description = "The scope of the group. A descriptor referencing the scope (collection, project) in which the group should be created. If omitted, will be created in the scope of the enclosing account or organization. Cannot be used simultaneously with origin_id or mail."
  type        = string
  default     = null

  validation {
    condition     = var.scope == null || (var.origin_id == null && var.mail == null)
    error_message = "scope cannot be used simultaneously with origin_id or mail."
  }
}

variable "display_name" {
  description = "The name of a new Azure DevOps group that is not backed by an external provider. Cannot be used simultaneously with origin_id or mail. Exactly one of display_name, origin_id, or mail must be set."
  type        = string
  default     = null

  validation {
    condition     = length([for v in [var.display_name, var.origin_id, var.mail] : v if v != null]) == 1
    error_message = "Exactly one of display_name, origin_id, or mail must be set."
  }
}

variable "origin_id" {
  description = "The OriginID as a reference to a group from an external AD or AAD backed provider. Cannot be used simultaneously with scope, mail, or display_name."
  type        = string
  default     = null
}

variable "mail" {
  description = "The mail address as a reference to an existing group from an external AD or AAD backed provider. Cannot be used simultaneously with scope, origin_id, or display_name."
  type        = string
  default     = null
}

variable "description" {
  description = "The description of the group."
  type        = string
  default     = null
}

variable "members" {
  description = "The descriptors of the members of the group. Cannot be used together with the azuredevops_group_membership resource for the same group, since the two ways of managing membership will conflict."
  type        = list(string)
  default     = null
}
