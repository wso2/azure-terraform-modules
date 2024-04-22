# -------------------------------------------------------------------------------------
#
# Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

output "azure_openai_account_id" {
  depends_on = [azurerm_cognitive_account.azure_openai_account]
  value      = azurerm_cognitive_account.azure_openai_account.id
}

output "azure_openai_account_endpoint" {
  depends_on = [azurerm_cognitive_account.azure_openai_account]
  value      = azurerm_cognitive_account.azure_openai_account.endpoint
}

output "azure_openai_account_primary_access_key" {
  depends_on = [azurerm_cognitive_account.azure_openai_account]
  value      = azurerm_cognitive_account.azure_openai_account.primary_access_key
}

output "azure_openai_account_secondary_access_key" {
  depends_on = [azurerm_cognitive_account.azure_openai_account]
  value      = azurerm_cognitive_account.azure_openai_account.secondary_access_key
}

output "azure_openai_deployment_id" {
  depends_on = [azurerm_cognitive_deployment.azure_openai_deployment]
  value      = [for azure_openai_deployment in azurerm_cognitive_deployment.azure_openai_deployment : azure_openai_deployment.id]
}
