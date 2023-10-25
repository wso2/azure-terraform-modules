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

resource "azurerm_subnet" "bastion_subnet" {
  name                                      = join("-", ["snet-bastion", var.padding])
  resource_group_name                       = var.resource_group_name
  virtual_network_name                      = var.virtual_network_name
  address_prefixes                          = [var.subnet_address_prefix]
  service_endpoints                         = ["Microsoft.Sql", "Microsoft.ContainerRegistry", "Microsoft.Storage"]
  private_endpoint_network_policies_enabled = true
}

resource "azurerm_route_table" "bastion_route_table" {
  name                = join("-", ["route-bastion", var.project, var.application_name, var.environment, var.location, var.padding])
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = var.tags
}

resource "azurerm_route" "internet_route" {
  name                   = "ToInternet"
  resource_group_name    = var.resource_group_name
  route_table_name       = azurerm_route_table.bastion_route_table.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = var.firewall_private_ip
  depends_on = [
    azurerm_route_table.bastion_route_table
  ]
}

resource "azurerm_subnet_route_table_association" "bastion_subnet_rt_association" {
  subnet_id      = azurerm_subnet.bastion_subnet.id
  route_table_id = azurerm_route_table.bastion_route_table.id
  depends_on = [
    azurerm_subnet.bastion_subnet,
    azurerm_route_table.bastion_route_table
  ]
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "bastion_nsg" {
  name                = join("-", ["nsg-bastion", var.project, var.application_name, var.environment, var.location, var.padding])
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = var.tags
}

# Create network interface
resource "azurerm_network_interface" "bastion_nic" {
  name                = join("-", ["nic-bastion", var.project, var.application_name, var.environment, var.location, var.padding])
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = var.tags
  depends_on = [
    azurerm_subnet.bastion_subnet
  ]

  ip_configuration {
    name                          = join("-", ["nic-bastion", var.project, var.application_name, var.environment, var.location, var.padding])
    subnet_id                     = azurerm_subnet.bastion_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Connect the security group to the subnet
resource "azurerm_subnet_network_security_group_association" "bastion_sec_association" {
  subnet_id                 = azurerm_subnet.bastion_subnet.id
  network_security_group_id = azurerm_network_security_group.bastion_nsg.id
  depends_on = [
    azurerm_subnet.bastion_subnet,
    azurerm_network_security_group.bastion_nsg
  ]
}

resource "azurerm_application_security_group" "bastion_application_security_group" {
  name                = join("-", ["asg-bastion", var.project, var.application_name, var.environment, var.location, var.padding])
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = var.tags
}

resource "azurerm_network_interface_application_security_group_association" "bastion_asg_association" {
  network_interface_id          = azurerm_network_interface.bastion_nic.id
  application_security_group_id = azurerm_application_security_group.bastion_application_security_group.id
  depends_on = [
    azurerm_network_interface.bastion_nic,
    azurerm_application_security_group.bastion_application_security_group
  ]
}
