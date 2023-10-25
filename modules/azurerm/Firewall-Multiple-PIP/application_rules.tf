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

resource "azurerm_firewall_application_rule_collection" "firewall_application_rule_collection" {
  name = join("-", ["fwapprc",
    var.shortened_project,
    var.application_name,
    "allowed",
    var.shortened_environment,
    var.shortened_location,
  var.shortened_padding])
  azure_firewall_name = azurerm_firewall.azure_firewall.name
  resource_group_name = var.resource_group_name
  priority            = var.application_rule_collection_priority
  action              = "Allow"
  dynamic "rule" {
    for_each = var.application_rules
    content {
      name             = rule.value.name
      source_addresses = rule.value.source_addresses
      target_fqdns     = rule.value.target_fqdns
      protocol {
        port = rule.value.protocol.port
        type = rule.value.protocol.type
      }
    }
  }
}
