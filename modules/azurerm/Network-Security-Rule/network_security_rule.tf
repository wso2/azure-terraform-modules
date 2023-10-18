# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

resource "azurerm_network_security_rule" "network_security_rule" {
  name                        = join("",[var.access,var.scope])
  priority                    = var.priority
  direction                   = var.direction
  access                      = var.access
  protocol                    = var.protocol
  source_port_range           = var.source_port_range
  destination_port_range      = var.destination_port_range
  source_port_ranges          = var.source_port_ranges
  destination_port_ranges     = var.destination_port_ranges
  source_address_prefix       = var.source_address_prefix
  destination_address_prefix  = var.destination_address_prefix
  source_address_prefixes     = var.source_address_prefixes
  destination_address_prefixes= var.destination_address_prefixes
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.nsg_name
}
