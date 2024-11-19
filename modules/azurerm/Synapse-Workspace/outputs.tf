# -------------------------------------------------------------------------------------
#
# Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com).
#
# WSO2 LLC. licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#
# --------------------------------------------------------------------------------------


output "id" {
  description = "The ID of the Synapse Workspace"
  value       = azurerm_synapse_workspace.synapse.id
}

output "connectivity_endpoints" {
  description = "A list of connectivity endpoints for the Synapse Workspace"
  value       = azurerm_synapse_workspace.synapse.connectivity_endpoints
}

output "managed_resource_group_name" {
  description = "The name of the Managed Resource Group for the Synapse Workspace"
  value       = azurerm_synapse_workspace.synapse.managed_resource_group_name
}
