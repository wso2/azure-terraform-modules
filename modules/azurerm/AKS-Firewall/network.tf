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

resource "azurerm_subnet" "aks_node_pool_subnet" {
  name                                      = join("-", ["snet", local.aks_node_pool_workload, var.padding])
  resource_group_name                       = var.resource_group_name
  virtual_network_name                      = var.virtual_network_name
  address_prefixes                          = [var.aks_node_pool_subnet_address_prefix]
  service_endpoints                         = ["Microsoft.Sql", "Microsoft.ContainerRegistry", "Microsoft.EventHub", "Microsoft.Storage"]
  private_endpoint_network_policies_enabled = true
}

resource "azurerm_route_table" "aks_node_pool_route_table" {
  name                = join("-", ["route", var.project, local.aks_node_pool_workload, var.environment, var.padding])
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  route {
    name                   = "ToFirewall"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.firewall_private_ip
  }

  route {
    name           = "Local"
    address_prefix = var.aks_node_pool_subnet_address_prefix
    next_hop_type  = "VnetLocal"
  }
}

resource "azurerm_subnet_route_table_association" "aks_node_pool_subnet_rt_association" {
  subnet_id      = azurerm_subnet.aks_node_pool_subnet.id
  route_table_id = azurerm_route_table.aks_node_pool_route_table.id
  depends_on     = [azurerm_subnet.aks_node_pool_subnet, azurerm_route_table.aks_node_pool_route_table]
}

resource "azurerm_network_security_group" "aks_node_pool_subnet_nsg" {
  location            = var.location
  name                = join("-", ["nsg", var.project, local.aks_node_pool_workload, var.environment, var.location, var.padding])
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_rule" "network_security_rule_allow_http_inbound" {
  name                         = "AllowHTTP"
  priority                     = 1000
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "Tcp"
  source_address_prefix        = var.firewall_subnet_address_prefix
  source_port_range            = "*"
  destination_address_prefixes = [var.internal_loadbalancer_subnet_address_prefix]
  destination_port_range       = "80"
  resource_group_name          = var.resource_group_name
  network_security_group_name  = azurerm_network_security_group.aks_node_pool_subnet_nsg.name
}

resource "azurerm_network_security_rule" "network_security_rule_allow_https_inbound" {
  name                         = "AllowHTTPS"
  priority                     = 1001
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "Tcp"
  source_address_prefix        = var.firewall_subnet_address_prefix
  source_port_range            = "*"
  destination_address_prefixes = [var.internal_loadbalancer_subnet_address_prefix]
  destination_port_range       = "443"
  resource_group_name          = var.resource_group_name
  network_security_group_name  = azurerm_network_security_group.aks_node_pool_subnet_nsg.name
}

resource "azurerm_network_security_rule" "network_security_rule_apgw_allow_https_inbound" {
  name                        = "AllowAPGWHTTPS"
  priority                    = 2050
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = var.application_gateway_subnet_address_prefix
  source_port_range           = "*"
  destination_port_range      = "8443"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.aks_node_pool_subnet_nsg.name
}

resource "azurerm_network_security_rule" "network_security_rule_allow_lb_inbound" {
  name                        = "AllowAzureLB"
  priority                    = 3000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "AzureLoadBalancer"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.aks_node_pool_subnet_nsg.name
}

resource "azurerm_network_security_rule" "network_security_rule_allow_intra_subnet_inbound" {
  name                        = "AllowIntraSubnet"
  priority                    = 3500
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefixes     = [var.aks_node_pool_subnet_address_prefix]
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.aks_node_pool_subnet_nsg.name
}

resource "azurerm_network_security_rule" "network_security_rule_block_vnet_inbound" {
  name                        = "BlockVnet"
  priority                    = 4000
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.aks_node_pool_subnet_nsg.name
}

# Connect the security group to the subnet
resource "azurerm_subnet_network_security_group_association" "aks_node_pool_subnet_sec_association" {
  subnet_id                 = azurerm_subnet.aks_node_pool_subnet.id
  network_security_group_id = azurerm_network_security_group.aks_node_pool_subnet_nsg.id
  depends_on                = [azurerm_subnet.aks_node_pool_subnet, azurerm_network_security_group.aks_node_pool_subnet_nsg]
}

resource "azurerm_subnet" "internal_load_balancer_subnet" {
  name                                      = join("-", ["snet", local.aks_internal_lb_workload, var.padding])
  resource_group_name                       = var.resource_group_name
  virtual_network_name                      = var.virtual_network_name
  address_prefixes                          = [var.internal_loadbalancer_subnet_address_prefix]
  service_endpoints                         = ["Microsoft.Sql", "Microsoft.ContainerRegistry", "Microsoft.EventHub", "Microsoft.Storage"]
  private_endpoint_network_policies_enabled = false
}

resource "azurerm_network_security_group" "internal_load_balancer_subnet_nsg" {
  location            = var.location
  name                = join("-", ["nsg", var.project, local.aks_internal_lb_workload, var.environment, var.location, var.padding])
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "internal_load_balancer_subnet_asg_association" {
  subnet_id                 = azurerm_subnet.internal_load_balancer_subnet.id
  network_security_group_id = azurerm_network_security_group.internal_load_balancer_subnet_nsg.id
  depends_on                = [azurerm_subnet.internal_load_balancer_subnet, azurerm_network_security_group.internal_load_balancer_subnet_nsg]
}
