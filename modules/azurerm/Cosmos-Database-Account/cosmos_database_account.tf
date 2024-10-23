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

resource "azurerm_cosmosdb_account" "cosmos_db_account" {
  name                              = join("-", ["cosmos", var.cosmosdb_account_name])
  location                          = var.location
  resource_group_name               = var.resource_group_name
  offer_type                        = var.offer_type
  kind                              = var.kind
  tags                              = var.tags
  enable_free_tier                  = var.enable_free_tier
  public_network_access_enabled     = var.public_network_access_enabled
  ip_range_filter                   = var.ip_range_filter
  enable_multiple_write_locations   = var.enable_multiple_write_locations
  enable_automatic_failover         = length(local.geo_locations) == 1 ? false : var.enable_automatic_failover
  is_virtual_network_filter_enabled = var.is_virtual_network_filter_enabled
  analytical_storage_enabled        = var.analytical_storage_enabled

  dynamic "geo_location" {
    for_each = local.geo_locations

    content {
      location          = geo_location.value.location
      failover_priority = geo_location.value.priority
      zone_redundant    = lookup(geo_location.value, "zone_redundant", true)
    }
  }

  consistency_policy {
    consistency_level       = var.consistency_policy_level
    max_interval_in_seconds = var.consistency_policy_max_interval_in_seconds
    max_staleness_prefix    = var.consistency_policy_max_staleness_prefix
  }

  backup {
    type                = var.backup_type
    interval_in_minutes = var.periodic_backup_interval
    retention_in_hours  = var.periodic_backup_retention_in_hours
    storage_redundancy  = var.backup_storage_redundancy
  }

  dynamic "capabilities" {
    for_each = var.capabilities

    content {
      name = capabilities.value
    }
  }

  dynamic "virtual_network_rule" {
    for_each = var.virtual_network_rule

    content {
      id                                   = virtual_network_rule.value.id
      ignore_missing_vnet_service_endpoint = virtual_network_rule.value.ignore_missing_vnet_service_endpoint
    }
  }
}
