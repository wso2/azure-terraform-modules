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
  description = "Logic app action http abbreviation to be used in the resource name"
  type        = string
  default     = "lgapp-achttp"
}

variable "logic_app_action_http_name" {
  description = "Name of the HTTP Action to be created within the Logic App Workflow"
  type        = string
}

variable "logic_app_id" {
  description = "The ID of the Logic App Workflow"
  type        = string
}

variable "method" {
  description = "The HTTP Method which should be used for the HTTP Action"
  type        = string
}

variable "uri" {
  description = "The URI which will be called when the HTTP Action is triggered"
  type        = string
}

variable "body" {
  description = "The HTTP Body that should be sent to the uri when this HTTP Action is triggered"
  type        = string
}

variable "headers" {
  description = "A map of Key-Value Pairs that should be sent to the uri when this HTTP Action is triggered"
  type        = map(string)
}

variable "queries" {
  description = "Map of Key-Value Pairs that should be sent to the uri when this HTTP Action is triggered"
  type        = map(string)
  default     = null
}
