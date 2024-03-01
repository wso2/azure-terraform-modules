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

resource "azurerm_network_security_group" "private_network_security_group" {
  name                = join("-", [var.nsg_abbreviation, var.network_security_group_name])
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "private_network_security_group_association" {
  subnet_id                 = azurerm_subnet.private_endpoint_subnet.id
  network_security_group_id = azurerm_network_security_group.private_network_security_group.id
}
