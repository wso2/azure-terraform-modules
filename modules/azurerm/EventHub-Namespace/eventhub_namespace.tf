# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 LLC. (https://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

resource "azurerm_eventhub_namespace" "eventhub_namespace" {
  name                = join("-",
    [
      "evhns",
      var.project,
      var.application_name,
      var.environment,
      var.location,
      var.padding
    ]
  )
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  capacity            = var.capacity
  auto_inflate_enabled = true
  maximum_throughput_units = var.maximum_throughput_units
  public_network_access_enabled = var.public_network_access_enabled

  lifecycle {
     ignore_changes = [
       capacity,
       zone_redundant,
     ]
  }
  zone_redundant      = true

  dynamic "network_rulesets" {
    for_each = var.network_rules != null ? ["true"] : []
    content {
      default_action = "Allow"

      dynamic "ip_rule" {
        for_each = var.network_rules.ip_rules
        iterator = iprule
        content {
          ip_mask = iprule.value
          action  = "Allow"
        }
      }

      dynamic "virtual_network_rule" {
        for_each = var.network_rules.subnet_ids
        iterator = subnet
        content {
          subnet_id = subnet.value
          ignore_missing_virtual_network_service_endpoint = true
        }
      }
    }
  }

  tags = var.default_tags
}
