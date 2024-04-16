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

resource "azurerm_route_table" "route_table" {
  name                = join("-", [var.route_table_abbreviation, var.route_table_name])
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  route {
    name                   = var.route_name
    address_prefix         = var.address_prefix
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.next_hop_in_ip_address
  }
}

resource "azurerm_subnet_route_table_association" "subnet_rt_association" {
  subnet_id      = var.subnet_id
  route_table_id = azurerm_route_table.route_table.id
  depends_on     = [azurerm_route_table.route_table]
}
