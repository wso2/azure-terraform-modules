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

output "azure_frontdoor_name" {
  description = "The name of the Azure Frontdoor"
  value       = azurerm_frontdoor.frontdoor.name
  depends_on  = [azurerm_frontdoor.frontdoor]
}

output "azure_frontdoor_id" {
  description = "The ID of the Azure Frontdoor"
  value       = azurerm_frontdoor.frontdoor.id
  depends_on  = [azurerm_frontdoor.frontdoor]
}

output "azure_header_frontdoor_id" {
  description = "The Header ID of the Azure Frontdoor"
  value       = azurerm_frontdoor.frontdoor.header_frontdoor_id
  depends_on  = [azurerm_frontdoor.frontdoor]
}

output "frontend_endpoints" {
  description = "The frontend endpoints of the Frontdoor"
  value       = azurerm_frontdoor.frontdoor.frontend_endpoints
  depends_on  = [azurerm_frontdoor.frontdoor]
}
