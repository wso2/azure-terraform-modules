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
  value      = azurerm_lb.internal_lb.id
  depends_on = [azurerm_lb.internal_lb]
}

output "private_ip_addresses" {
  value      = azurerm_lb.internal_lb.private_ip_addresses
  depends_on = [azurerm_lb.internal_lb]
}

output "frontend_ip_configuration_name" {
  value      = azurerm_lb.internal_lb.frontend_ip_configuration[0].name
  depends_on = [azurerm_lb.internal_lb]
}