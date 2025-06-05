# -------------------------------------------------------------------------------------
#
# Copyright (c) 2025, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

# Create child DNS zone
resource "azurerm_dns_zone" "child_dns_zone" {
  name                = join(".", [var.child_dns_name, var.base_dns_name])
  resource_group_name = var.resource_group_name
}

resource "azurerm_dns_ns_record" "child_dns_ns_record" {
  name                = var.child_dns_name
  zone_name           = var.base_dns_name
  resource_group_name = var.resource_group_name
  ttl                 = 60

  records = azurerm_dns_zone.child_dns_zone.name_servers
  depends_on = [
    azurerm_dns_zone.child_dns_zone
  ]
}
