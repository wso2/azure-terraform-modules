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

variable "project_id" {
  description = "The ID of the project to assign the permissions in."
  type        = string
}

variable "principal" {
  description = "The group principal to assign the permissions to. Individual user/service principal descriptors are not supported by this resource; use a group descriptor."
  type        = string
}

variable "permissions" {
  description = "A map of permissions to assign. Each value must be Allow, Deny, or NotSet. Valid keys: GENERIC_READ, GENERIC_WRITE, DELETE, PUBLISH_TEST_RESULTS, ADMINISTER_BUILD, START_BUILD, EDIT_BUILD_STATUS, UPDATE_BUILD, DELETE_TEST_RESULTS, VIEW_TEST_RESULTS, MANAGE_TEST_ENVIRONMENTS, MANAGE_TEST_CONFIGURATIONS, WORK_ITEM_DELETE, WORK_ITEM_MOVE, WORK_ITEM_PERMANENTLY_DELETE, RENAME, MANAGE_PROPERTIES, MANAGE_SYSTEM_PROPERTIES, BYPASS_PROPERTY_CACHE, BYPASS_RULES, SUPPRESS_NOTIFICATIONS, UPDATE_VISIBILITY, CHANGE_PROCESS, AGILETOOLS_BACKLOG, AGILETOOLS_PLANS."
  type        = map(string)

  validation {
    condition     = alltrue([for v in values(var.permissions) : contains(["Allow", "Deny", "NotSet"], v)])
    error_message = "Each permission value must be one of: Allow, Deny, NotSet."
  }
}

variable "replace" {
  description = "Replace (true) or merge (false) the permissions with any already set on the project."
  type        = bool
  default     = true
}
