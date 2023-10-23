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

output "static_site_id" {
  depends_on = [azurerm_static_site.static_site]
  value      = azurerm_static_site.static_site.id
}

output "static_site_api_key" {
  depends_on = [azurerm_static_site.static_site]
  value      = azurerm_static_site.static_site.api_key
}

output "static_site_default_host_name" {
  depends_on = [azurerm_static_site.static_site]
  value      = azurerm_static_site.static_site.default_host_name
}

output "static_site_identity" {
  depends_on = [azurerm_static_site.static_site]
  value      = azurerm_static_site.static_site.identity
}

output "static_site_custom_domain_id" {
  depends_on = [azurerm_static_site_custom_domain.static_site_custom_domain]
  value      = azurerm_static_site_custom_domain.static_site_custom_domain.0.id
}

output "static_site_custom_domain_validation_token" {
  depends_on = [azurerm_static_site_custom_domain.static_site_custom_domain]
  value      = azurerm_static_site_custom_domain.static_site_custom_domain.0.validation_token
}
