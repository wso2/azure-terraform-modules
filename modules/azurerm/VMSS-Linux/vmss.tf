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

resource "azurerm_linux_virtual_machine_scale_set" "linux_virtual_machine_scale_set" {
  name                = join("-", [var.vmss_abbreviation, var.name])
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  instances           = var.instances
  admin_username      = var.admin_username
  tags                = var.tags
  zone_balance        = var.zone_balance
  zones               = var.zones
  upgrade_mode        = var.upgrade_mode
  health_probe_id     = var.health_probe_id

  # handle autoscaling diff
  lifecycle {
    ignore_changes = [
      instances
    ]
  }

  admin_ssh_key {
    username   = var.admin_ssh_username
    public_key = file(var.admin_ssh_public_key_path)
  }

  dynamic "source_image_reference" {
    for_each = local.valid_input && local.reference_set ? [var.source_image_reference] : []
    content {
      publisher = source_image_reference.value["publisher"]
      offer     = source_image_reference.value["offer"]
      sku       = source_image_reference.value["sku"]
      version   = source_image_reference.value["version"]
    }
  }

  source_image_id = local.valid_input && local.image_set ? var.source_image_id : null

  dynamic "rolling_upgrade_policy" {
    for_each = local.rolling_upgrade_enabled ? [var.rolling_upgrade_policy] : []
    content {
      cross_zone_upgrades_enabled             = rolling_upgrade_policy.value["cross_zone_upgrades_enabled"]
      max_batch_instance_percent              = rolling_upgrade_policy.value["max_batch_instance_percent"]
      max_unhealthy_instance_percent          = rolling_upgrade_policy.value["max_unhealthy_instance_percent"]
      max_unhealthy_upgraded_instance_percent = rolling_upgrade_policy.value["max_unhealthy_upgraded_instance_percent"]
      pause_time_between_batches              = rolling_upgrade_policy.value["pause_time_between_batches"]
    }
  }

  os_disk {
    storage_account_type = var.os_disk_storage_account_type
    caching              = var.os_disk_caching
    disk_size_gb         = var.os_disk_size_gb
  }

  network_interface {
    name                      = join("-", [var.nic_abbreviation, var.nic_name])
    primary                   = true
    network_security_group_id = var.nic_network_security_group_id

    ip_configuration {
      name                                         = "internal"
      primary                                      = true
      subnet_id                                    = var.subnet_id
      application_gateway_backend_address_pool_ids = var.application_gateway_backend_address_pool_ids
      load_balancer_backend_address_pool_ids       = var.load_balancer_backend_address_pool_ids
    }
  }
}
