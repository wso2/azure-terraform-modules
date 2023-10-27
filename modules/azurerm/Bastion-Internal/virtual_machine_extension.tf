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

resource "azurerm_virtual_machine_extension" "ad_login_virtual_machine_extension" {
  name                       = "AADSSHLoginForLinux"
  virtual_machine_id         = azurerm_linux_virtual_machine.bastion_linux_virtual_machine.id
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADSSHLoginForLinux"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
}

module "sre-task-automation-repository" {
  source = "git::https://github.com/wso2-enterprise/sre-task-automation?ref=v1.15.0"
}

resource "azurerm_virtual_machine_extension" "data_disk_attachment" {
  name                 = "AttachDataDisk"
  virtual_machine_id   = azurerm_linux_virtual_machine.bastion_linux_virtual_machine.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"
  settings             = <<SETTINGS
    {
        "script": "${base64encode(replace(file(module.sre-task-automation-repository.mount_vm_data_disk_shell_script), "disk_lun_value", local.bastion_vm_managed_disk_attachment_lun))}"
    }
SETTINGS
  depends_on = [
    azurerm_linux_virtual_machine.bastion_linux_virtual_machine,
    azurerm_virtual_machine_data_disk_attachment.bastion_vm_managed_disk_attachment
  ]
}

resource "azurerm_virtual_machine_extension" "azure_monitor_agent_extension" {
  count                      = var.enable_ama_agent == false ? 0 : 1
  name                       = "AzureMonitorLinuxAgent"
  virtual_machine_id         = azurerm_linux_virtual_machine.bastion_linux_virtual_machine.id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
}
