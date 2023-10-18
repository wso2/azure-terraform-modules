# -------------------------------------------------------------------------------------
#
# Copyright (c) 2020, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

output "virtual_network_name" {
  depends_on = [azurerm_virtual_network.virtual_network]
  value = azurerm_virtual_network.virtual_network.name
}

output "virtual_network_id" {
  depends_on = [azurerm_virtual_network.virtual_network]
  value = azurerm_virtual_network.virtual_network.id
}
