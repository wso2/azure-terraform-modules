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

output "vnet_peering_src_id" {
  description = "Virtual network src peering id"
  value       = azurerm_virtual_network_peering.peering_src.id
}

output "vnet_peering_src_name" {
  description = "Virtual network src peering name"
  value       = azurerm_virtual_network_peering.peering_src.name
}

output "vnet_peering_dest_id" {
  description = "Virtual network dest peering id"
  value       = azurerm_virtual_network_peering.peering_dest.id
}

output "vnet_peering_dest_name" {
  description = "Virtual network dest peering name"
  value       = azurerm_virtual_network_peering.peering_dest.name
}
