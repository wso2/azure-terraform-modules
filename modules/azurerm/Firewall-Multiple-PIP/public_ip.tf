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

resource "azurerm_public_ip_prefix" "public_ip_prefix_fw" {
  name                = join("-", ["pipp", var.project, join("", ["fw", var.application_name]), var.environment, var.padding])
  location            = var.location
  resource_group_name = var.resource_group_name
  prefix_length       = var.public_ip_prefix_length
  zones               = [1, 2, 3]
  tags                = var.tags
}

resource "azurerm_public_ip" "firewall_public_ip" {
  for_each            = var.dynamic_nat_rules
  name                = join("-", ["pip", var.project, join("", ["fw", var.application_name, each.key]), var.environment, var.location, var.padding])
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  public_ip_prefix_id = null == var.dynamic_nat_rules[each.key].public_ip_prefix_id ? azurerm_public_ip_prefix.public_ip_prefix_fw.id : var.dynamic_nat_rules[each.key].public_ip_prefix_id
  zones               = [1, 2, 3]
  tags                = var.tags
  depends_on = [
    azurerm_public_ip_prefix.public_ip_prefix_fw
  ]
}

