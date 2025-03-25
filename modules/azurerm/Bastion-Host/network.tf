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

resource "azurerm_subnet" "bastion_host_subnet" {
  name                              = var.bastion_subnet_name
  resource_group_name               = var.resource_group_name
  virtual_network_name              = var.virtual_network_name
  address_prefixes                  = [var.subnet_address_prefixes]
  private_endpoint_network_policies = var.private_endpoint_network_policies
}

resource "azurerm_network_security_group" "bastion_host_nsg" {
  name                = join("-", [var.nsg_abbreviation, var.network_security_group_name])
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "network_security_rule_allow_https_internet_inbound" {
  count                       = var.allow_https_internet_inbound == true ? 1 : 0
  name                        = "AllowHttpsInBound"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion_host_nsg.name
}

resource "azurerm_network_security_rule" "network_security_rule_allow_https_vpn_inbound" {
  count                       = var.allow_https_internet_inbound == false ? 1 : 0
  name                        = "AllowHttpsInBound"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefixes     = var.public_address_prefixes
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion_host_nsg.name
}

resource "azurerm_network_security_rule" "network_security_rule_allow_gateway_manager_inbound" {
  name                        = "AllowGatewayManagerInBound"
  priority                    = 210
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "GatewayManager"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion_host_nsg.name
}

resource "azurerm_network_security_rule" "network_security_rule_allow_azure_load_balancer_inbound" {
  name                        = "AllowAzureLoadBalancerInBound"
  priority                    = 220
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "AzureLoadBalancer"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion_host_nsg.name
}

resource "azurerm_network_security_rule" "network_security_rule_allow_bastion_host_communication_inbound" {
  name                        = "AllowBastionHostCommunication"
  priority                    = 230
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["8080", "5701"]
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion_host_nsg.name
}

resource "azurerm_network_security_rule" "network_security_rule_allow_ssh_rdp_outbound" {
  name                        = "AllowSshRdpOutBound"
  priority                    = 200
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_ranges     = ["3389", "22"]
  source_address_prefix       = "*"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion_host_nsg.name
}

resource "azurerm_network_security_rule" "network_security_rule_allow_azure_cloud_outbound" {
  name                        = "AllowAzureCloudOutBound"
  priority                    = 210
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "AzureCloud"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion_host_nsg.name
}

resource "azurerm_network_security_rule" "network_security_rule_allow_bastion_communication_outbound" {
  name                        = "AllowBastionCommunication"
  priority                    = 220
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["8080", "5701"]
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion_host_nsg.name
}

resource "azurerm_network_security_rule" "network_security_rule_allow_get_session_information_outbound" {
  name                        = "AllowGetSessionInformation"
  priority                    = 230
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "Internet"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion_host_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "bastion_host_sec_association" {
  subnet_id                 = azurerm_subnet.bastion_host_subnet.id
  network_security_group_id = azurerm_network_security_group.bastion_host_nsg.id
  depends_on = [
    azurerm_subnet.bastion_host_subnet,
    azurerm_network_security_group.bastion_host_nsg
  ]
}
