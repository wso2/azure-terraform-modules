# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 LLC (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

resource "azurerm_virtual_machine_scale_set_extension" "azure_monitor_agent_extension" {
  count                        = var.enable_ama_agent==false ? 0 : 1
  name                         = "AzureMonitorLinuxAgent"
  virtual_machine_scale_set_id =  azurerm_linux_virtual_machine_scale_set.scale_set_agent_linux_virtual_machine_scale_set.id
  publisher                    = "Microsoft.Azure.Monitor"
  type                         = "AzureMonitorLinuxAgent"
  type_handler_version         = var.ama_type_handler_version
  auto_upgrade_minor_version   = var.ama_auto_upgrade_minor_version
  automatic_upgrade_enabled    = var.ama_automatic_upgrade_enabled

  lifecycle {
    ignore_changes = [
      type_handler_version
    ]
  }
}
