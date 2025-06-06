# -------------------------------------------------------------------------------------
#
# Copyright (c) 2025, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
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

resource "azurerm_container_registry_scope_map" "registry_scope_map" {
  name                    = join("-", [var.scopemap_resource_name, var.project, var.environment, var.scope_map_name])
  container_registry_name = var.container_registry_name
  resource_group_name     = var.resource_group_name
  actions                 = var.actions
}

resource "azurerm_container_registry_token" "registry_token" {
  name                    = join("-", [var.token_resource_name, var.project, var.environment, var.scope_map_name])
  container_registry_name = var.container_registry_name
  resource_group_name     = var.resource_group_name
  scope_map_id            = azurerm_container_registry_scope_map.registry_scope_map.id
}

resource "azurerm_container_registry_token_password" "registry_token_password" {
  container_registry_token_id = azurerm_container_registry_token.registry_token.id

  password1 {
    expiry = var.token_password_1_expiry
  }
  password2 {
    expiry = var.token_password_2_expiry
  }
}
