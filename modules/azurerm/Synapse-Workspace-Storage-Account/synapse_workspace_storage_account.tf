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

resource "azurerm_storage_account" "storage_account" {
  name                             = join("", ["st", var.storage_account_name])
  resource_group_name              = var.resource_group_name
  location                         = var.location
  account_tier                     = var.account_tier
  account_replication_type         = var.account_replication_type
  account_kind                     = var.account_kind
  is_hns_enabled                   = var.is_hns_enabled
  cross_tenant_replication_enabled = var.cross_tenant_replication_enabled
  tags                             = var.tags
}

resource "azurerm_storage_data_lake_gen2_filesystem" "storage_data_lake_gen2_filesystem" {
  name               = join("", ["fs", var.storage_account_name])
  storage_account_id = azurerm_storage_account.storage_account.id
}

resource "azurerm_synapse_workspace" "synapse_workspace" {
  name                                 = join("-", ["synw", var.name])
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.storage_data_lake_gen2_filesystem.id
  sql_administrator_login              = var.sql_administrator_login
  sql_administrator_login_password     = var.sql_administrator_login_password
  managed_virtual_network_enabled      = var.managed_virtual_network_enabled
  data_exfiltration_protection_enabled = var.data_exfiltration_protection_enabled
  identity {
    type = "SystemAssigned"
  }
  tags = var.tags
}

resource "azurerm_synapse_firewall_rule" "synapse_firewall_rule" {
  name                 = var.fw_rule_name
  synapse_workspace_id = azurerm_synapse_workspace.synapse_workspace.id
  start_ip_address     = var.fw_start_ip_address
  end_ip_address       = var.fw_end_ip_address
}

resource "azurerm_synapse_integration_runtime_azure" "synapse_integration_runtime_azure" {
  name                 = join("-", ["synintruntime", var.name])
  synapse_workspace_id = azurerm_synapse_workspace.synapse_workspace.id
  location             = azurerm_synapse_workspace.synapse_workspace.location
}

resource "azurerm_synapse_linked_service" "synapse_linked_service" {
  name                 = join("-", ["synls", var.name])
  synapse_workspace_id = azurerm_synapse_workspace.synapse_workspace.id
  type                 = var.synapse_linked_service_type
  type_properties_json = <<JSON
{
  "connectionString": "${var.connection_string != null ? var.connection_string : azurerm_storage_account.storage_account.primary_connection_string}"
}
JSON
  integration_runtime {
    name = azurerm_synapse_integration_runtime_azure.synapse_integration_runtime_azure.name
  }

  depends_on = [
    azurerm_synapse_firewall_rule.synapse_firewall_rule
  ]
}
