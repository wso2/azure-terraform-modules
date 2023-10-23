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

resource "azurerm_firewall" "azure_firewall" {
  name                = join("-", ["fw", var.project, var.application_name, var.environment, var.location, var.padding])
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.default_tags
  zones               = var.zones
  sku_name            = var.sku_name
  sku_tier            = var.sku_tier

  dynamic "ip_configuration" {
    for_each = var.dynamic_nat_rules
    iterator = ip
    content {
      name                 = var.dynamic_nat_rules[ip.key].fw_ip_association_name
      subnet_id            = ip.key == local.public_ip_names[0] ? azurerm_subnet.firewall_subnet.id : null
      public_ip_address_id = azurerm_public_ip.firewall_public_ip[ip.key].id
    }
  }
}
