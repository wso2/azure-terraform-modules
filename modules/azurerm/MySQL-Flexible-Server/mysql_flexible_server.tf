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

resource "azurerm_mysql_flexible_server" "mysql_server" {
  name                         = join("-", compact([var.mysql_server_abbreviation, var.mysql_server_name]))
  resource_group_name          = var.resource_group_name
  location                     = var.location
  administrator_login          = var.administrator_login
  administrator_password       = var.administrator_password
  backup_retention_days        = var.backup_retention_days
  create_mode                  = var.create_mode
  delegated_subnet_id          = azurerm_subnet.mysql_server_subnet.id
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  private_dns_zone_id          = var.private_dns_zone_id
  public_network_access        = var.public_network_access
  replication_role             = var.replication_role
  sku_name                     = var.sku_name
  version                      = var.mysql_version
  zone                         = var.zone
  tags                         = var.tags

  dynamic "high_availability" {
    for_each = var.high_availability_enabled ? [1] : []
    content {
      mode                      = var.ha_mode
      standby_availability_zone = var.ha_standby_availability_zone
    }
  }

  dynamic "storage" {
    for_each = var.storage_enabled ? [1] : []
    content {
      auto_grow_enabled   = var.storage_auto_grow_enabled
      io_scaling_enabled  = var.storage_io_scaling_enabled
      iops                = var.storage_iops
      log_on_disk_enabled = var.storage_log_on_disk_enabled
      size_gb             = var.storage_size_gb
    }
  }
}
