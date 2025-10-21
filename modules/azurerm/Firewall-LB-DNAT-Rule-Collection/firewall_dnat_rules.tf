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

resource "azurerm_firewall_nat_rule_collection" "public_loadbalancer_dnat_rules" {
  name                = join("-", ["fwnatrc", var.firewall_nat_rule_collection_name])
  azure_firewall_name = var.firewall_name
  resource_group_name = var.resource_group_name
  priority            = var.priority
  action              = "Dnat"

  dynamic "rule" {
    for_each = var.dynamic_nat_rules
    iterator = ip

    content {
      name = join("-", ["internal", var.dynamic_nat_rules[ip.key].nat_rule_name_shortned, "dnat-rule-443", ip.key])
      source_addresses  = var.source_addresses
      destination_ports = [
        "443",
      ]
      destination_addresses = [
        var.dynamic_nat_rules[ip.key].public_ip_address
      ]
      translated_port    = 443
      translated_address = var.dynamic_nat_rules[ip.key].private_ip_address
      protocols = [
        "TCP"
      ]
    }
  }
}
