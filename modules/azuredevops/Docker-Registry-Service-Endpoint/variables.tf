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
  description = "The ID of the project."
  type        = string
}

variable "service_endpoint_name" {
  description = "The name of the service endpoint."
  type        = string
}

variable "description" {
  description = "The description of the service endpoint."
  type        = string
}

variable "docker_registry" {
  description = "The URL of the Docker registry."
  type        = string
}

variable "docker_username" {
  description = "The username for the Docker registry."
  type        = string
  sensitive   = true
}

variable "docker_email" {
  description = "The email for the Docker registry."
  type        = string
  sensitive   = true
  default     = null
}

variable "docker_password" {
  description = "The password for the Docker registry."
  type        = string
  sensitive   = true
}

variable "registry_type" {
  description = "The type of the Docker registry."
  type        = string
  default     = "DockerHub"
}
