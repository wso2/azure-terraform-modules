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

output "storage_account_name" {
  depends_on = [azurerm_storage_account.static_storage]
  value      = azurerm_storage_account.static_storage.name
}

output "storage_account_id" {
  depends_on = [azurerm_storage_account.static_storage]
  value      = azurerm_storage_account.static_storage.id
}

output "storage_account_primary_web_endpoint" {
  depends_on = [azurerm_storage_account.static_storage]
  value      = azurerm_storage_account.static_storage.primary_web_endpoint
}

output "storage_account_secondary_web_endpoint" {
  depends_on = [azurerm_storage_account.static_storage]
  value      = azurerm_storage_account.static_storage.secondary_web_endpoint
}
