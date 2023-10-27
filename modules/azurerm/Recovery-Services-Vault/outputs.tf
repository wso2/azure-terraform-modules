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

output "recovery_vault_name" {
  depends_on = [azurerm_recovery_services_vault.recovery_services_vault]
  value      = azurerm_recovery_services_vault.recovery_services_vault.name
}

output "recovery_vault_id" {
  depends_on = [azurerm_recovery_services_vault.recovery_services_vault]
  value      = azurerm_recovery_services_vault.recovery_services_vault.id
}
