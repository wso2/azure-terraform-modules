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

resource "azurerm_virtual_network_peering" "peering_src" {
  name = coalesce(
    var.custom_peering_dest_name,
    format("peering-to-%s", local.vnet_dest_name),
  )
  resource_group_name          = local.vnet_src_resource_group_name
  virtual_network_name         = local.vnet_src_name
  remote_virtual_network_id    = var.vnet_dest_id
  allow_virtual_network_access = var.allow_virtual_src_network_access
  allow_forwarded_traffic      = var.allow_forwarded_src_traffic
  allow_gateway_transit        = var.allow_gateway_src_transit
  use_remote_gateways          = var.use_remote_src_gateway
}

resource "azurerm_virtual_network_peering" "peering_dest" {
  name = coalesce(
    var.custom_peering_src_name,
    format("peering-to-%s", local.vnet_src_name),
  )
  resource_group_name          = local.vnet_dest_resource_group_name
  virtual_network_name         = local.vnet_dest_name
  remote_virtual_network_id    = var.vnet_src_id
  allow_virtual_network_access = var.allow_virtual_dest_network_access
  allow_forwarded_traffic      = var.allow_forwarded_dest_traffic
  allow_gateway_transit        = var.allow_gateway_dest_transit
  use_remote_gateways          = var.use_remote_dest_gateway
}
