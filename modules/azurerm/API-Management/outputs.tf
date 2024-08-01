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

output "id" {
  value      = azurerm_api_management.api_management.id
  depends_on = [azurerm_api_management.api_management]
}

output "name" {
  value      = azurerm_api_management.api_management.name
  depends_on = [azurerm_api_management.api_management]
}

output "gateway_url" {
  value      = azurerm_api_management.api_management.gateway_url
  depends_on = [azurerm_api_management.api_management]
}

output "public_ip_addresses" {
  value      = azurerm_api_management.api_management.public_ip_addresses
  depends_on = [azurerm_api_management.api_management]
}
