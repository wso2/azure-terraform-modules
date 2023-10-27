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

output "vm_id" {
  value      = azurerm_linux_virtual_machine.automation_linux_virtual_machine.id
  depends_on = [azurerm_linux_virtual_machine.automation_linux_virtual_machine]
}

output "network_interface_id" {
  value      = azurerm_network_interface.automation_vm_nic.id
  depends_on = [azurerm_network_interface.automation_vm_nic]
}

output "automation_vm_identity_object_id" {
  depends_on = [azurerm_linux_virtual_machine.automation_linux_virtual_machine]
  value      = azurerm_linux_virtual_machine.automation_linux_virtual_machine.identity[0].principal_id
}

output "vm_private_ip" {
  value      = azurerm_linux_virtual_machine.automation_linux_virtual_machine.private_ip_address
  depends_on = [azurerm_linux_virtual_machine.automation_linux_virtual_machine]
}
