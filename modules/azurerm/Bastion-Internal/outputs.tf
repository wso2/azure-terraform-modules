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

output "bastion_subnet_id" {
  value      = azurerm_subnet.bastion_subnet.id
  depends_on = [azurerm_subnet.bastion_subnet]
}

output "bastion_application_security_group_id" {
  value      = azurerm_application_security_group.bastion_application_security_group.id
  depends_on = [azurerm_application_security_group.bastion_application_security_group]
}

output "bastion_vm_id" {
  value      = azurerm_linux_virtual_machine.bastion_linux_virtual_machine.id
  depends_on = [azurerm_linux_virtual_machine.bastion_linux_virtual_machine]
}

output "bastion_vm_name" {
  value      = azurerm_linux_virtual_machine.bastion_linux_virtual_machine.name
  depends_on = [azurerm_linux_virtual_machine.bastion_linux_virtual_machine]
}

output "bastion_network_security_group_id" {
  value      = azurerm_network_security_group.bastion_nsg.id
  depends_on = [azurerm_network_security_group.bastion_nsg]
}

output "network_interface_id" {
  value      = azurerm_network_interface.bastion_nic.id
  depends_on = [azurerm_network_interface.bastion_nic]
}

output "storage_account_name" {
  depends_on = [azurerm_storage_account.storage_account]
  value      = azurerm_storage_account.storage_account.name
}

output "storage_account_primary_endpoint" {
  depends_on = [azurerm_storage_account.storage_account]
  value      = azurerm_storage_account.storage_account.primary_web_endpoint
}

output "storage_account_primary_access_key" {
  depends_on = [azurerm_storage_account.storage_account]
  value      = azurerm_storage_account.storage_account.primary_access_key
}

output "storage_account_id" {
  depends_on = [azurerm_storage_account.storage_account]
  value      = azurerm_storage_account.storage_account.id
}

output "storage_account_primary_connection_string" {
  depends_on = [azurerm_storage_account.storage_account]
  value      = azurerm_storage_account.storage_account.primary_connection_string
}
