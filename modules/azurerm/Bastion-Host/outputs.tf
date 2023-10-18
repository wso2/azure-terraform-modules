# -------------------------------------------------------------------------------------
#
# Copyright (c) 2023, WSO2 LLC (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

output "bastion_host_id" {
  value      = azurerm_bastion_host.bastion_host.id
  depends_on = [azurerm_bastion_host.bastion_host]
}

output "bastion_public_ip" {
  value      = azurerm_public_ip.bastion_host_public_ip.id
  depends_on = [azurerm_public_ip.bastion_host_public_ip]
}

output "bastion_public_ip_address" {
  value      = azurerm_public_ip.bastion_host_public_ip.ip_address
  depends_on = [azurerm_public_ip.bastion_host_public_ip]
}

output "bastion_public_ip_name" {
  value      = azurerm_public_ip.bastion_host_public_ip.name
  depends_on = [azurerm_public_ip.bastion_host_public_ip]
}
