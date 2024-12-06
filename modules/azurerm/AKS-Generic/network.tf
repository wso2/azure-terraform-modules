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
  name                              = join("-", ["snet", var.aks_node_pool_subnet_name])
  resource_group_name               = local.virtual_network_resource_group_name
  virtual_network_name              = var.virtual_network_name
  address_prefixes                  = [var.aks_node_pool_subnet_address_prefix]
  service_endpoints                 = var.aks_nodepool_subnet_allowed_service_endpoints
  private_endpoint_network_policies = var.aks_nodepool_subnet_enforce_private_link_endpoint_network_policies
}

resource "azurerm_route_table" "aks_node_pool_route_table" {
  name                = join("-", ["route", var.aks_node_pool_subnet_route_table_name])
  location            = var.location
  resource_group_name = local.virtual_network_resource_group_name
  tags                = var.tags
}

resource "azurerm_route" "aks_node_pool_route" {
  for_each               = var.aks_node_pool_subnet_routes
  name                   = each.value.name
  resource_group_name    = local.virtual_network_resource_group_name
  route_table_name       = azurerm_route_table.aks_node_pool_route_table.name
  address_prefix         = each.value.address_prefix
  next_hop_type          = each.value.next_hop_type
  next_hop_in_ip_address = each.value.next_hop_in_ip_address
}

resource "azurerm_subnet_route_table_association" "subnet_rt_association" {
  subnet_id      = azurerm_subnet.aks_node_pool_subnet.id
  route_table_id = azurerm_route_table.aks_node_pool_route_table.id
  depends_on     = [azurerm_subnet.aks_node_pool_subnet, azurerm_route_table.aks_node_pool_route_table]
}

resource "azurerm_network_security_group" "aks_node_pool_subnet_nsg" {
  location            = var.location
  name                = join("-", ["nsg", var.aks_node_pool_subnet_network_security_group_name])
  resource_group_name = local.virtual_network_resource_group_name
}

resource "azurerm_network_security_rule" "aks_node_pool_subnet_nsg_rules" {
  for_each                                   = var.aks_node_pool_subnet_nsg_rules
  resource_group_name                        = local.virtual_network_resource_group_name
  network_security_group_name                = azurerm_network_security_group.aks_node_pool_subnet_nsg.name
  name                                       = each.value.name
  description                                = each.value.description
  priority                                   = each.value.priority
  direction                                  = each.value.direction
  access                                     = each.value.access
  protocol                                   = each.value.protocol
  source_port_ranges                         = each.value.source_port_ranges
  destination_port_ranges                    = each.value.destination_port_ranges
  source_address_prefixes                    = each.value.source_address_prefixes
  destination_address_prefixes               = each.value.destination_address_prefixes
  source_application_security_group_ids      = each.value.source_application_security_group_ids
  destination_application_security_group_ids = each.value.destination_application_security_group_ids
  depends_on = [
    azurerm_network_security_group.aks_node_pool_subnet_nsg
  ]
}

# Connect the security group to the subnet
resource "azurerm_subnet_network_security_group_association" "aks_node_pool_subnet_sec_association" {
  subnet_id                 = azurerm_subnet.aks_node_pool_subnet.id
  network_security_group_id = azurerm_network_security_group.aks_node_pool_subnet_nsg.id
  depends_on = [
    azurerm_subnet.aks_node_pool_subnet,
    azurerm_network_security_group.aks_node_pool_subnet_nsg
  ]
}

resource "azurerm_subnet" "internal_load_balancer_subnet" {
  name                              = join("-", ["snet", var.aks_load_balancer_subnet_name])
  resource_group_name               = local.virtual_network_resource_group_name
  virtual_network_name              = var.virtual_network_name
  address_prefixes                  = [var.internal_loadbalancer_subnet_address_prefix]
  service_endpoints                 = ["Microsoft.Sql", "Microsoft.ContainerRegistry", "Microsoft.EventHub", "Microsoft.Storage"]
  private_endpoint_network_policies = var.internal_load_balancer_subnet_enforce_private_link_endpoint_network_policies
}

resource "azurerm_network_security_group" "internal_load_balancer_subnet_nsg" {
  location            = var.location
  name                = join("-", ["nsg", var.aks_load_balancer_subnet_network_security_group_name])
  resource_group_name = var.virtual_network_resource_group_name
}

resource "azurerm_network_security_rule" "aks_load_balancer_subnet_nsg_rules" {
  for_each                                   = var.aks_load_balancer_subnet_nsg_rules
  resource_group_name                        = local.virtual_network_resource_group_name
  network_security_group_name                = azurerm_network_security_group.internal_load_balancer_subnet_nsg.name
  name                                       = each.value.name
  description                                = each.value.description
  priority                                   = each.value.priority
  direction                                  = each.value.direction
  access                                     = each.value.access
  protocol                                   = each.value.protocol
  source_port_ranges                         = each.value.source_port_ranges
  destination_port_ranges                    = each.value.destination_port_ranges
  source_address_prefixes                    = each.value.source_address_prefixes
  destination_address_prefixes               = each.value.destination_address_prefixes
  source_application_security_group_ids      = each.value.source_application_security_group_ids
  destination_application_security_group_ids = each.value.destination_application_security_group_ids
  depends_on = [
    azurerm_network_security_group.aks_node_pool_subnet_nsg
  ]
}

resource "azurerm_subnet_network_security_group_association" "internal_load_balancer_subnet_asg_association" {
  subnet_id                 = azurerm_subnet.internal_load_balancer_subnet.id
  network_security_group_id = azurerm_network_security_group.internal_load_balancer_subnet_nsg.id
  depends_on                = [azurerm_subnet.internal_load_balancer_subnet, azurerm_network_security_group.internal_load_balancer_subnet_nsg]
}
