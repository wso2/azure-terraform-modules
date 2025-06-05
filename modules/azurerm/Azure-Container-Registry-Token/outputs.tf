# -------------------------------------------------------------------------------------
#
# Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

output "azure_container_registry_token_id" {
  value = azurerm_container_registry_token.registry_token.id
}

output "azure_container_registry_token_password" {
  value = azurerm_container_registry_token_password.registry_token_password.password1[0].value
}
