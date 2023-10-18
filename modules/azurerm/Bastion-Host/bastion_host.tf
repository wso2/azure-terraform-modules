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

resource "azurerm_bastion_host" "bastion_host" {
  name                   = join("-", ["bastion", var.project, var.application_name, var.environment, var.location, var.padding])
  resource_group_name    = var.resource_group_name
  location               = var.location
  copy_paste_enabled     = var.copy_paste_enabled
  file_copy_enabled      = var.file_copy_enabled
  ip_connect_enabled     = var.ip_connect_enabled
  scale_units            = var.scale_units
  shareable_link_enabled = var.shareable_link_enabled
  tunneling_enabled      = var.tunneling_enabled
  sku                    = var.sku
  tags                   = var.default_tags

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion_host_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_host_public_ip.id
  }

  depends_on = [
    azurerm_subnet.bastion_host_subnet,
    azurerm_public_ip.bastion_host_public_ip
  ]
}
