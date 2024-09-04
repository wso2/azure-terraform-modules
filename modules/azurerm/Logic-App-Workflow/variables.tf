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


variable "abbreviation" {
  description = "Logic app workflow abbreviation to be used in the resource name"
  type        = string
  default     = "lgapp"
}
variable "logic_app_workflow_name" {
  description = "Name of the Azure Logic App Workflow"
  type        = string
}

variable "location" {
  description = "The location of the resource need to be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which the Azure Logic App Workflow will be created"
  type        = string
}
