# -------------------------------------------------------------------------------------
#
# Copyright (c) 2023-2025, WSO2 LLC. (http://www.wso2.com).
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

resource "azurerm_mssql_database" "mssql_database" {
  name                           = join("-", [var.mssql_database_abbreviation, var.mssql_database_name])
  server_id                      = var.server_id
  elastic_pool_id                = var.elastic_pool_id
  collation                      = var.collation
  read_scale                     = var.read_scale
  sku_name                       = var.sku_name
  min_capacity                   = var.min_capacity
  max_size_gb                    = var.max_size_gb
  auto_pause_delay_in_minutes    = var.auto_pause_delay_in_minutes
  zone_redundant                 = var.zone_redundant
  maintenance_configuration_name = var.maintenance_configuration_name
  tags                           = var.tags

  short_term_retention_policy {
    retention_days = var.short_term_retention_policy_retention_days
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      auto_pause_delay_in_minutes
    ]
  }
}
