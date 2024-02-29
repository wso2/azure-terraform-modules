# -------------------------------------------------------------------------------------
#
# Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

resource "azurerm_shared_image_gallery" "compute_gallery" {
  name                = join("_", [var.shared_image_gallery_abbreviation, var.name])
  resource_group_name = var.resource_group
  location            = var.location
  description         = var.description

  tags = var.default_tags
}
