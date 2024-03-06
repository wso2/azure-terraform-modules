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

resource "azurerm_virtual_machine_scale_set_extension" "ad_login_virtual_machine_extension" {
  name                         = "AADSSHLoginForLinux"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.linux_virtual_machine_scale_set.id
  publisher                    = "Microsoft.Azure.ActiveDirectory"
  type                         = "AADSSHLoginForLinux"
  type_handler_version         = "1.0"
  auto_upgrade_minor_version   = true

  depends_on = [
    azurerm_linux_virtual_machine_scale_set.linux_virtual_machine_scale_set
  ]
}
