# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

output "cosmos_db_sql_container_id" {
  depends_on = [azurerm_cosmosdb_sql_container.cosmosdb_sql_container]
  value      = azurerm_cosmosdb_sql_container.cosmosdb_sql_container.id
}
