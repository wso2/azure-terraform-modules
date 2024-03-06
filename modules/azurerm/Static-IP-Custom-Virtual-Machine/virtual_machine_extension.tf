# -------------------------------------------------------------------------------------
#
# Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

resource "azurerm_virtual_machine_extension" "azure_monitor_agent_extension" {
  count                      = var.enable_ama_agent == false ? 0 : 1
  name                       = "AzureMonitorLinuxAgent"
  virtual_machine_id         = azurerm_linux_virtual_machine.static_ip_linux_virtual_machine.id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
}

resource "azurerm_virtual_machine_extension" "ad_login_virtual_machine_extension" {
  name                         = "AADSSHLoginForLinux"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine.static_ip_linux_virtual_machine.id
  publisher                    = "Microsoft.Azure.ActiveDirectory"
  type                         = "AADSSHLoginForLinux"
  type_handler_version         = "1.0"
  auto_upgrade_minor_version   = true

  depends_on = [
    azurerm_linux_virtual_machine.static_ip_linux_virtual_machine
  ]
}
