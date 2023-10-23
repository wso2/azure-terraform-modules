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
output "mssql_id" {
  depends_on = [azurerm_mssql_database.mssql_database]
  value      = azurerm_mssql_database.mssql_database.id
}

output "mssql_app_name" {
  value = var.application_name
}

output "mssql_workload" {
  value = var.workload
}

output "mssql_db_name" {
  depends_on = [azurerm_mssql_database.mssql_database]
  value      = azurerm_mssql_database.mssql_database.name
}
