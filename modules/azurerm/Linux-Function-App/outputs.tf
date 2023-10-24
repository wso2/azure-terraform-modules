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

output "linux_function_app_id" {
  depends_on = [azurerm_linux_function_app.linux_function_app]
  value      = azurerm_linux_function_app.linux_function_app.id
}

output "linux_function_app_name" {
  depends_on = [azurerm_linux_function_app.linux_function_app]
  value      = azurerm_linux_function_app.linux_function_app.name
}

output "identity_principal_id" {
  depends_on = [azurerm_linux_function_app.linux_function_app]
  value      = azurerm_linux_function_app.linux_function_app.identity[0].principal_id
}

output "identity_tenant_id" {
  depends_on = [azurerm_linux_function_app.linux_function_app]
  value      = azurerm_linux_function_app.linux_function_app.identity[0].tenant_id
}
