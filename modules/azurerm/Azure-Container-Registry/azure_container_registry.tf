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

resource "azurerm_container_registry" "acr" {
  name                          = join("", ["cr", var.name])
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = "Premium"
  admin_enabled                 = true
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags

  dynamic "georeplications" {
    for_each = var.georeplication_locations

    content {
      location                = georeplications.value.location
      zone_redundancy_enabled = georeplications.value.zrs_enabled
      tags                    = {}
    }
  }

  dynamic "network_rule_set" {
    for_each = var.network_rules != null ? ["true"] : []

    content {
      default_action = var.network_rule_set_default_action

      dynamic "ip_rule" {
        for_each = var.network_rules.ip_rules
        iterator = iprule

        content {
          action   = "Allow"
          ip_range = iprule.value
        }
      }
    }
  }
}
