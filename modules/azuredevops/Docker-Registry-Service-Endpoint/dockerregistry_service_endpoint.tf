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

resource "azuredevops_serviceendpoint_dockerregistry" "devops_serviceendpoint_dockerregistry" {
  project_id            = var.project_id
  service_endpoint_name = var.service_endpoint_name
  description           = var.description
  docker_registry       = var.docker_registry
  docker_username       = var.docker_username
  docker_email          = var.docker_email
  docker_password       = var.docker_password
  registry_type         = var.registry_type
}
