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

resource "azurerm_managed_disk" "bastion_vm_managed_disk" {
  name                 = join("", ["diskbastion", var.managed_disk_name])
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.managed_disk_size_gb
}

resource "azurerm_virtual_machine_data_disk_attachment" "bastion_vm_managed_disk_attachment" {
  managed_disk_id    = azurerm_managed_disk.bastion_vm_managed_disk.id
  virtual_machine_id = azurerm_linux_virtual_machine.bastion_linux_virtual_machine.id
  lun                = var.managed_disk_attachment_lun
  caching            = "ReadWrite"
  depends_on         = [azurerm_linux_virtual_machine.bastion_linux_virtual_machine, azurerm_managed_disk.bastion_vm_managed_disk]
}
