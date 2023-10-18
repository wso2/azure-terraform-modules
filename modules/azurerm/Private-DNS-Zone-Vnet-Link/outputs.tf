# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

output "private_dns_zone_virtual_network_link_id" {
  depends_on = [azurerm_private_dns_zone_virtual_network_link.private_dns_zone_virtual_network_link]
  value = azurerm_private_dns_zone_virtual_network_link.private_dns_zone_virtual_network_link.id
}
