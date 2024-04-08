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

resource "azuredevops_elastic_pool" "elastic_pool" {
  name                   = var.pool_name
  service_endpoint_id    = var.service_endpoint_id
  service_endpoint_scope = var.service_endpoint_scope
  desired_idle           = var.desired_idle
  max_capacity           = var.max_capacity
  project_id             = var.project_id
  azure_resource_id      = var.vmss_resource_id
  recycle_after_each_use = var.recycle_after_each_use
  time_to_live_minutes   = var.time_to_live_minutes
  agent_interactive_ui   = var.agent_interactive_ui
  auto_provision         = var.auto_provision
  auto_update            = var.auto_update
}
