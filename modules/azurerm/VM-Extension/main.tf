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

# Generic Extension Installation
resource "azurerm_virtual_machine_extension" "generic_extension" {
    name                        = var.vm_extension_peering_name
    virtual_machine_id          = var.linux_virtual_machine_id
    publisher                   = var.vm_extension_publisher
    type                        = var.vm_extension_type
    type_handler_version        = var.vm_extension_type_handler_version
    auto_upgrade_minor_version  = var.vm_extension_auto_upgrade_minor_version
    settings                    = var.vm_extension_settings
    protected_settings          = var.vm_extension_protected_settings
    tags                        = var.vm_extension_tags
    timeouts {
        create = var.vm_extension_create_timeout
        update = var.vm_extension_update_timeout
        read   = var.vm_extension_read_timeout
        delete = var.vm_extension_delete_timeout
    }
}
