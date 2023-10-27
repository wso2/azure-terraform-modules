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

output "azurerm_mssql_server_fqdn" {
  depends_on = [azurerm_mssql_server.mssql_server]
  value      = azurerm_mssql_server.mssql_server.fully_qualified_domain_name
}

output "azurerm_mssql_server_id" {
  depends_on = [azurerm_mssql_server.mssql_server]
  value      = azurerm_mssql_server.mssql_server.id
}

output "azurerm_mssql_server_name" {
  depends_on = [azurerm_mssql_server.mssql_server]
  value      = azurerm_mssql_server.mssql_server.name
}

output "azurerm_mssql_server_identity_object_id" {
  value = azurerm_mssql_server.mssql_server.identity[0].principal_id
}
