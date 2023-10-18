# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022 WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------
output "id" {
  depends_on = [azurerm_key_vault_secret.key_vault_secret]
  value      = zipmap(keys(azurerm_key_vault_secret.key_vault_secret), values(azurerm_key_vault_secret.key_vault_secret)[*]["id"])
  sensitive  = true
}

output "version" {
  value = zipmap(keys(azurerm_key_vault_secret.key_vault_secret), values(azurerm_key_vault_secret.key_vault_secret)[*]["version"])
  description = "Key Vault secret version"
}

output "name" {
  value = zipmap(keys(azurerm_key_vault_secret.key_vault_secret), values(azurerm_key_vault_secret.key_vault_secret)[*]["name"])
  description = "Key Vault secret name"
}
