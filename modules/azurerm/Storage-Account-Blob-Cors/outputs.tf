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
  depends_on = [azurerm_storage_account.storage_account]
  value      = azurerm_storage_account.storage_account.name
}

output "storage_account_primary_endpoint" {
  depends_on = [azurerm_storage_account.storage_account]
  value      = azurerm_storage_account.storage_account.primary_web_endpoint
}

output "storage_account_primary_web_host" {
  depends_on = [azurerm_storage_account.storage_account]
  value      = azurerm_storage_account.storage_account.primary_web_host
}

output "storage_account_primary_access_key" {
  depends_on = [azurerm_storage_account.storage_account]
  value      = azurerm_storage_account.storage_account.primary_access_key
}

output "storage_account_id" {
  depends_on = [azurerm_storage_account.storage_account]
  value      = azurerm_storage_account.storage_account.id
}

output "storage_account_primary_connection_string" {
  depends_on = [azurerm_storage_account.storage_account]
  value      = azurerm_storage_account.storage_account.primary_connection_string
}

output "storage_account_primary_blob_endpoint" {
  depends_on = [azurerm_storage_account.storage_account]
  value      = azurerm_storage_account.storage_account.primary_blob_endpoint
}

output "storage_account_primary_blob_host" {
  depends_on = [azurerm_storage_account.storage_account]
  value      = azurerm_storage_account.storage_account.primary_blob_host
}

output "storage_account_secondary_blob_endpoint" {
  depends_on = [azurerm_storage_account.storage_account]
  value      = azurerm_storage_account.storage_account.secondary_blob_endpoint
}

output "storage_account_secondary_blob_host" {
  depends_on = [azurerm_storage_account.storage_account]
  value      = azurerm_storage_account.storage_account.secondary_blob_host
}
