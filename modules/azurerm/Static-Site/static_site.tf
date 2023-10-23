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

resource "azurerm_static_site" "static_site" {
  name                = join("-", ["stapp", var.project, var.application_name, var.environment, var.padding])
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_tier            = var.sku_tier
  sku_size            = var.sku_size
  dynamic "identity" {
    for_each = var.identity_type != null ? [1] : []
    content {
      type         = var.identity_type
      identity_ids = var.identity_ids
    }
  }
  tags = var.default_tags
}

resource "azurerm_static_site_custom_domain" "static_site_custom_domain" {
  count           = var.custom_domain_name != null ? 1 : 0
  static_site_id  = azurerm_static_site.static_site.id
  domain_name     = var.custom_domain_name
  validation_type = var.custom_domain_validation_type
}
