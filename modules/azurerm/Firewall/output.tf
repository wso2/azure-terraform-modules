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

output "firewall_id" {
  depends_on = [azurerm_firewall.azure_firewall]
  value      = azurerm_firewall.azure_firewall.id
}

output "firewall_name" {
  depends_on = [azurerm_firewall.azure_firewall]
  value      = azurerm_firewall.azure_firewall.name
}

output "firewall_private_ip" {
  depends_on = [azurerm_firewall.azure_firewall]
  value      = azurerm_firewall.azure_firewall.ip_configuration[0].private_ip_address
}

output "firewall_public_ips" {
  value      = [for pip in azurerm_public_ip.firewall_public_ip : pip.id]
  depends_on = [azurerm_public_ip.firewall_public_ip]
}

output "firewall_public_ip_addresses" {
  value      = [for pip in azurerm_public_ip.firewall_public_ip : pip.ip_address]
  depends_on = [azurerm_public_ip.firewall_public_ip]
}

output "firewall_public_ip_names" {
  value      = [for pip in azurerm_public_ip.firewall_public_ip : pip.name]
  depends_on = [azurerm_public_ip.firewall_public_ip]
}

output "firewall_public_ip_associations" {
  value      = {for pip in azurerm_public_ip.firewall_public_ip : pip.name => pip.ip_address}
  depends_on = [azurerm_public_ip.firewall_public_ip]
}
