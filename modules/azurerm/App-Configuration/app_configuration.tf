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

resource "azurerm_app_configuration" "app_configuration" {
  name                       = join("-", [var.app_configuration_abbreviation, var.app_configuration_name])
  resource_group_name        = var.resource_group_name
  location                   = var.location
  local_auth_enabled         = var.local_auth_enabled
  public_network_access      = var.public_network_access
  purge_protection_enabled   = var.purge_protection_enabled
  sku                        = var.sku
  soft_delete_retention_days = var.soft_delete_retention_days
  tags                       = var.tags

  dynamic "replica" {
    for_each = var.replicas
    content {
      name     = replica.value.name
      location = replica.value.location
    }
  }
}
