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

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_virtual_network_link" {
  count                 = length(var.private_dns_zones)
  name                  = join("-", ["pvtdnsvnl", var.private_dns_zone_vnet_link_name])
  depends_on            = [azurerm_virtual_network.virtual_network]
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = var.private_dns_zones[count.index].zone_name
  virtual_network_id    = azurerm_virtual_network.virtual_network.id
}
