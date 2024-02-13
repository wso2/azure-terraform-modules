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

output "azurerm_application_gateway_id" {
  depends_on = [azurerm_application_gateway.app_gateway]
  value      = azurerm_application_gateway.app_gateway.id
}

output "azurerm_network_security_group_id" {
  depends_on = [azurerm_network_security_group.network_security_group]
  value      = azurerm_network_security_group.network_security_group.id
}

output "azurerm_subnet_id" {
  depends_on = [azurerm_subnet.app_gateway_subnet]
  value      = azurerm_subnet.app_gateway_subnet.id
}

output "azurerm_application_gateway_name" {
  depends_on = [azurerm_application_gateway.app_gateway]
  value      = azurerm_application_gateway.app_gateway.name
}

output "apgw_backend_address_pool_id" {
  depends_on = [azurerm_application_gateway.app_gateway]
  value      = tolist(azurerm_application_gateway.app_gateway.backend_address_pool).0.id
}
