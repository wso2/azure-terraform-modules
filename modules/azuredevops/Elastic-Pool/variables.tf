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

variable "pool_name" {
  description = "The name of the elastic pool."
  type        = string
}

variable "service_endpoint_id" {
  description = "The ID of the service endpoint."
  type        = string
}
variable "service_endpoint_scope" {
  description = "The scope of the service endpoint."
  type        = string
}

variable "desired_idle" {
  description = "Number of agents to keep on standby."
  type        = number
}

variable "max_capacity" {
  description = "Maximum number of virtual machines in the scale set"
  type        = number
}

variable "project_id" {
  description = "The ID of the project where a new Elastic Pool will be created."
  default     = null
  type        = string
}

variable "vmss_resource_id" {
  description = "The ID of the VMSS resource."
  type        = string
}

variable "recycle_after_each_use" {
  description = "Tear down virtual machines after every use."
  default     = false
  type        = bool
}

variable "time_to_live_minutes" {
  description = "Delay in minutes before deleting excess idle agents."
  default     = 30
  type        = number
}

variable "agent_interactive_ui" {
  description = "Set whether agents should be configured to run with interactive UI."
  default     = false
  type        = bool
}

variable "auto_provision" {
  description = "Specifies whether a queue should be automatically provisioned for each project collection."
  default     = false
  type        = bool
}

variable "auto_update" {
  description = "Specifies whether or not agents within the pool should be automatically updated."
  default     = true
  type        = bool
}
