# -------------------------------------------------------------------------------------
#
# Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------


resource "azurerm_route_table" "route_table_firewall_egress" {
  name                = join("-", ["route", var.project, join("", ["firewallegress", var.workload]), var.environment, var.padding])
  location            = var.location
  resource_group_name = var.resource_group_name

  route {
    name                   = "ToFirewall"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.firewall_private_ip
  }
  tags = var.tags
}

resource "azurerm_subnet_route_table_association" "aks_node_pool_subnet_rt_association" {
  depends_on     = [azurerm_route_table.route_table_firewall_egress]
  subnet_id      = var.subnet_id
  route_table_id = azurerm_route_table.route_table_firewall_egress.id
}
