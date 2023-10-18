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

output "private_endpoint_id" {
  depends_on = [azurerm_private_endpoint.private_endpoint]
  value = azurerm_private_endpoint.private_endpoint.id
}

output "network_interface_id" {
  depends_on = [azurerm_private_endpoint.private_endpoint]
  value = azurerm_private_endpoint.private_endpoint.network_interface[0].id
}

output "ip_addresses" {
  depends_on = [azurerm_private_endpoint.private_endpoint]
  value = azurerm_private_endpoint.private_endpoint.private_service_connection[0].private_ip_address
}
