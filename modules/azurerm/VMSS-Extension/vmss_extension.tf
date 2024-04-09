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

# Generic Extension Installation
resource "azurerm_virtual_machine_scale_set_extension" "vmss_extension" {
  name                         = var.vmss_extension_peering_name
  virtual_machine_scale_set_id = var.linux_vmss_id
  publisher                    = var.vmss_extension_publisher
  type                         = var.vmss_extension_type
  type_handler_version         = var.vmss_extension_type_handler_version
  auto_upgrade_minor_version   = var.vmss_extension_auto_upgrade_minor_version
  settings                     = var.vmss_extension_settings
  protected_settings           = var.vmss_extension_protected_settings

  timeouts {
    create = var.vmss_extension_create_timeout
    update = var.vmss_extension_update_timeout
    read   = var.vmss_extension_read_timeout
    delete = var.vmss_extension_delete_timeout
  }
}
