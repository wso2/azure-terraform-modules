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

resource "azurerm_cdn_profile" "cdn_profile" {
  name                = join("-", ["cdnp", local.cdnp_name_without_prefix])
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.cdn_sku_profile
  tags                = var.cdn_tags
}
