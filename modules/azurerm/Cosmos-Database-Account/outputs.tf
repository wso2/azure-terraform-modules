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

output "cosmos_db_account_id" {
  depends_on = [azurerm_cosmosdb_account.cosmos_db_account]
  value      = azurerm_cosmosdb_account.cosmos_db_account.id
}

output "cosmos_db_account_endpoint" {
  depends_on = [azurerm_cosmosdb_account.cosmos_db_account]
  value      = azurerm_cosmosdb_account.cosmos_db_account.endpoint
}

output "cosmos_db_account_read_endpoints" {
  depends_on = [azurerm_cosmosdb_account.cosmos_db_account]
  value      = azurerm_cosmosdb_account.cosmos_db_account.read_endpoints
}

output "cosmos_db_account_write_endpoints" {
  depends_on = [azurerm_cosmosdb_account.cosmos_db_account]
  value      = azurerm_cosmosdb_account.cosmos_db_account.write_endpoints
}

output "cosmos_db_account_primary_sql_connection_string" {
  depends_on = [azurerm_cosmosdb_account.cosmos_db_account]
  value      = azurerm_cosmosdb_account.cosmos_db_account.primary_sql_connection_string
}

output "cosmos_db_account_secondary_sql_connection_string" {
  depends_on = [azurerm_cosmosdb_account.cosmos_db_account]
  value      = azurerm_cosmosdb_account.cosmos_db_account.secondary_sql_connection_string
}

output "cosmos_db_account_name" {
  depends_on = [azurerm_cosmosdb_account.cosmos_db_account]
  value      = azurerm_cosmosdb_account.cosmos_db_account.name
}

output "cosmos_db_account_primary_key" {
  depends_on = [azurerm_cosmosdb_account.cosmos_db_account]
  value      = azurerm_cosmosdb_account.cosmos_db_account.primary_key
}
