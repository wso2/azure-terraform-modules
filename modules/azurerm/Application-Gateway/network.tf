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

resource "azurerm_network_security_group" "network_security_group" {
  location            = var.location
  name                = join("-", ["nsg", var.application_gateway_network_security_group_name])
  resource_group_name = var.resource_group_name
  depends_on          = [azurerm_subnet.app_gateway_subnet]
}

resource "azurerm_network_security_rule" "network_security_rule" {
  for_each                     = var.network_security_rules
  name                         = each.value.name
  priority                     = each.value.priority
  direction                    = each.value.direction
  access                       = each.value.access
  protocol                     = each.value.protocol
  source_address_prefix        = each.value.source_address_prefix
  source_address_prefixes      = each.value.source_address_prefixes
  source_port_range            = each.value.source_port_range
  destination_address_prefix   = each.value.destination_address_prefix
  destination_address_prefixes = each.value.destination_address_prefixes
  destination_port_range       = each.value.destination_port_range
  resource_group_name          = var.resource_group_name
  network_security_group_name  = azurerm_network_security_group.network_security_group.name
}

resource "azurerm_network_security_rule" "default_network_security_rule" {
  name                        = "AzureInfrastructureCommunication"
  priority                    = var.default_ns_rule_1_priority
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_address_prefix       = "GatewayManager"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "65200-65535"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.network_security_group.name
}

resource "azurerm_network_security_rule" "default_network_security_rule_2" {
  name                        = "AllowTrafficLoadBalancer"
  priority                    = var.default_ns_rule_2_priority
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_address_prefix       = "AzureLoadBalancer"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.network_security_group.name
}

resource "azurerm_subnet_network_security_group_association" "nsg_subnet_association" {
  subnet_id                 = azurerm_subnet.app_gateway_subnet.id
  network_security_group_id = azurerm_network_security_group.network_security_group.id
}
