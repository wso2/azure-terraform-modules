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

resource "azurerm_cosmosdb_sql_database" "cosmos_sql_database" {
  name                = var.cosmos_sql_database_name
  resource_group_name = var.resource_group_name
  account_name        = var.cosmos_db_account_name
  throughput          = var.is_autoscaled == false ? var.throughput : null

  dynamic "autoscale_settings" {
    for_each = local.autoscale_setting
    content {
      max_throughput = autoscale_settings.value
    }
  }

}
