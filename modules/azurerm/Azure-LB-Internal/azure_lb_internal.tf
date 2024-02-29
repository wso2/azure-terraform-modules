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

resource "azurerm_lb" "internal_lb" {
  name                = join("-", [var.lb_name_abbreviation, var.lb_name])
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  sku                 = var.sku
  sku_tier            = var.sku_tier

  dynamic "frontend_ip_configuration" {
    for_each = var.frontend_ip_configuration

    content {
      name                          = frontend_ip_configuration.value["name"]
      private_ip_address_allocation = frontend_ip_configuration.value["private_ip_address_allocation"]
      subnet_id                     = frontend_ip_configuration.value["subnet_id"]
      private_ip_address            = frontend_ip_configuration.value["private_ip_address"]
    }
  }
}
