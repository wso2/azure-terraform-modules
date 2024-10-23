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

resource "azurerm_cosmosdb_sql_container" "cosmosdb_sql_container" {
  name                   = var.container_name
  resource_group_name    = var.resource_group_name
  account_name           = var.cosmos_db_account_name
  database_name          = var.cosmos_db_name
  partition_key_path     = var.partition_key_path
  partition_key_version  = var.partition_key_version
  throughput             = var.autoscale_enabled == false ? var.throughput : null
  default_ttl            = var.default_ttl
  analytical_storage_ttl = var.analytical_storage_ttl

  dynamic "autoscale_settings" {
    for_each = local.autoscale_setting

    content {
      max_throughput = autoscale_settings.value
    }
  }

  dynamic "unique_key" {
    for_each = var.unique_key_paths

    content {
      paths = unique_key.value
    }
  }
}
