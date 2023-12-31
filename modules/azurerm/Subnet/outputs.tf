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

output "subnet_id" {
  depends_on = [azurerm_subnet.subnet]
  value      = azurerm_subnet.subnet.id
}

output "subnet_nsg_id" {
  depends_on = [azurerm_network_security_group.network_security_group]
  value      = azurerm_network_security_group.network_security_group.id
}

output "subnet_nsg_name" {
  depends_on = [azurerm_network_security_group.network_security_group]
  value      = azurerm_network_security_group.network_security_group.name
}
