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

variable "build_definition_id" {
  description = "The ID of the build definition to assign the permissions to."
  type        = string
}

variable "permissions" {
  description = "A map of permissions to assign. Each value must be Allow, Deny, or NotSet. Valid keys: ViewBuilds, EditBuildQuality, RetainIndefinitely, DeleteBuilds, ManageBuildQualities, DestroyBuilds, UpdateBuildInformation, QueueBuilds, ManageBuildQueue, StopBuilds, ViewBuildDefinition, EditBuildDefinition, DeleteBuildDefinition, OverrideBuildCheckInValidation, AdministerBuildPermissions, CreateBuildDefinition, EditPipelineQueueConfigurationPermission."
  type        = map(string)
}

variable "replace" {
  description = "Replace (true) or merge (false) the permissions with any already set on the build definition."
  type        = bool
  default     = true
}
