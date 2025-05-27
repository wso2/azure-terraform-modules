# -------------------------------------------------------------------------------------
#
# Copyright (c) 2023, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

resource "azurerm_postgresql_flexible_server" "postgresql_flexible_server" {
  name                          = join("-", ["postgresql", var.server_name])
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = var.postgresql_server_version
  delegated_subnet_id           = var.subnet_id
  private_dns_zone_id           = var.private_dns_zone_id
  administrator_login           = var.postgresql_server_admin_username
  administrator_password        = var.postgresql_server_admin_password
  zone                          = var.availability_zone
  storage_mb                    = var.storage_size
  geo_redundant_backup_enabled  = var.geo_redundant_backup_enabled
  sku_name                      = var.sku_name
  backup_retention_days         = var.backup_retention_days
  create_mode                   = var.create_mode
  source_server_id              = var.source_server_id
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags

  dynamic "high_availability" {
    for_each = var.high_availability_mode != null ? [1] : []
    content {
      mode                      = var.high_availability_mode
      standby_availability_zone = var.high_availability_standby_availability_zone
    }
  }

  maintenance_window {
    day_of_week  = var.maintainance_start_day
    start_hour   = var.maintainance_start_hour
    start_minute = var.maintainance_start_minute
  }

  lifecycle {
    ignore_changes = [
      zone,
      high_availability
    ]
  }
}
