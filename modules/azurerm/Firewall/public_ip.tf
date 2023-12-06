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

resource "azurerm_public_ip" "firewall_public_ip" {
  for_each            = var.public_ip_prefixes
  name                = join("-", ["pip", each.value.public_ip_name])
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  public_ip_prefix_id = var.public_ip_prefixes[each.key].public_ip_prefix_id
  zones               = [1, 2, 3]
  tags                = var.tags
}
