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

resource "azurerm_mssql_elasticpool" "mssql_elasticpool" {
  name                = join("-", [var.mssql_elasticpool_abbreviation, var.mssql_elasticpool_name])
  resource_group_name = var.resource_group_name
  location            = var.location
  server_name         = var.mssql_server_name
  license_type        = var.elastic_pool_license_type
  max_size_gb         = var.elastic_pool_max_size_gb

  sku {
    name     = var.elastic_pool_sku_name
    tier     = var.elastic_pool_sku_tier
    capacity = var.elastic_pool_sku_capacity
    family   = var.elastic_pool_sku_family
  }

  per_database_settings {
    min_capacity = var.elastic_pool_per_database_settings_min_capacity
    max_capacity = var.elastic_pool_per_database_settings_max_capacity
  }

  lifecycle {
    ignore_changes  = [license_type, ]
    prevent_destroy = true
  }
}
