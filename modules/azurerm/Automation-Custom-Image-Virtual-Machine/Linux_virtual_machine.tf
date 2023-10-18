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

resource "azurerm_linux_virtual_machine" "automation_linux_virtual_machine" {
  name                            = join("", ["vm", var.project, var.application_name, var.environment, var.location, var.padding])
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.size
  admin_username                  = var.admin_username
  computer_name                   = join("", ["vm", var.project, var.application_name, var.environment, var.padding])
  source_image_id                 = var.source_image_id
  tags                            = var.default_tags
  network_interface_ids = [
    azurerm_network_interface.automation_vm_nic.id
  ]

  admin_ssh_key {
    username = var.admin_username
    public_key = file(var.public_key_path)
  }

  os_disk {
    name                 = join("", [ "osdisk", var.project, var.application_name, var.location, var.padding])
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
    disk_size_gb         = var.os_disk_size_gb
  }
  
  identity {
    type = "SystemAssigned"
  } 
}
