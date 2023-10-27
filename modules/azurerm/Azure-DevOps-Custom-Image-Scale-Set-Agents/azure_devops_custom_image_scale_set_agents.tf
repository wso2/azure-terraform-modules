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

resource "azurerm_linux_virtual_machine_scale_set" "scale_set_agent_linux_virtual_machine_scale_set" {
  name                        = join("-", ["vmss", var.project, local.scale_set_agents_application_name, var.environment, var.location, var.padding])
  resource_group_name         = var.resource_group_name
  location                    = var.location
  sku                         = var.sku
  instances                   = var.instances_count
  admin_username              = var.admin_username
  overprovision               = false
  upgrade_mode                = "Manual"
  single_placement_group      = false
  platform_fault_domain_count = 1
  source_image_id             = var.source_image_id
  tags                        = var.tags
  depends_on                  = [azurerm_subnet.scale_set_agent_subnet]

  lifecycle {
    ignore_changes = [
      tags, instances
    ]
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.admin_ssh_public_key)
  }

  os_disk {
    storage_account_type = "StandardSSD_LRS"
    caching              = "ReadOnly"
  }

  network_interface {
    name    = join("-", ["nic", var.project, local.scale_set_agents_application_name, var.environment, var.location, var.padding])
    primary = var.network_interface_is_primary

    ip_configuration {
      name      = var.network_interface_ip_configuration_name
      primary   = var.network_interface_ip_configuration_is_primary
      subnet_id = azurerm_subnet.scale_set_agent_subnet.id
    }
  }

  identity {
    type = "SystemAssigned"
  }
}
