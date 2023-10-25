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

resource "azurerm_route_table" "private_endpoint_route_table" {
  name                = join("-", ["route-private-endpoint", var.project, var.application_name, var.environment, var.location, var.padding])
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = var.tags

  route {
    name           = "ToInternet"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }

  route {
    name           = "Local"
    address_prefix = var.address_prefixes
    next_hop_type  = "VnetLocal"
  }
}

resource "azurerm_subnet_route_table_association" "private_endpoint_subnet_rt_association" {
  subnet_id      = azurerm_subnet.private_endpoint_subnet.id
  route_table_id = azurerm_route_table.private_endpoint_route_table.id
  depends_on     = [azurerm_subnet.private_endpoint_subnet, azurerm_route_table.private_endpoint_route_table]
}
