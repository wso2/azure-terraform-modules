# -------------------------------------------------------------------------------------
#
# Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

output "storage_account_name" {
  depends_on = [azurerm_storage_account.storage_account]
  value = azurerm_storage_account.storage_account.name
}

output "storage_account_id" {
  depends_on = [azurerm_storage_account.storage_account]
  value = azurerm_storage_account.storage_account.id
}

output "storage_account_primary_access_key" {
  depends_on = [azurerm_storage_account.storage_account]
  value = azurerm_storage_account.storage_account.primary_access_key
}

output "storage_account_secondary_access_key" {
  depends_on = [azurerm_storage_account.storage_account]
  value = azurerm_storage_account.storage_account.secondary_access_key
}

output "backup_policy_file_share_id" {
  depends_on = [azurerm_backup_policy_file_share.backup_policy_file_share]
  value = azurerm_backup_policy_file_share.backup_policy_file_share.id
}

output "backup_container_storage_account_id" {
  depends_on = [azurerm_backup_container_storage_account.backup_container_storage_account]
  value = azurerm_backup_container_storage_account.backup_container_storage_account.id
}
