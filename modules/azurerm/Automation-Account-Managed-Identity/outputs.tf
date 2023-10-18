# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

output "automation_account_name" {
  depends_on = [azurerm_automation_account.automation_account]
  value      = azurerm_automation_account.automation_account.name
}

output "automation_account_id" {
  depends_on = [azurerm_automation_account.automation_account]
  value      = azurerm_automation_account.automation_account.id
}

output "automation_account_dsc_server_endpoint" {
  depends_on = [azurerm_automation_account.automation_account]
  value      = azurerm_automation_account.automation_account.dsc_server_endpoint
}

output "automation_account_dsc_primary_access_key" {
  depends_on = [azurerm_automation_account.automation_account]
  value      = azurerm_automation_account.automation_account.dsc_primary_access_key
}

output "automation_account_dsc_secondary_access_key" {
  depends_on = [azurerm_automation_account.automation_account]
  value      = azurerm_automation_account.automation_account.dsc_secondary_access_key
}

output "automation_account_managed_identity_id" {
  depends_on = [azurerm_automation_account.automation_account]
  value = azurerm_automation_account.automation_account.identity[0].principal_id
}

output "automation_account_hybrid_service_url" {
  depends_on = [azurerm_automation_account.automation_account]
  value      = azurerm_automation_account.automation_account.hybrid_service_url
}
