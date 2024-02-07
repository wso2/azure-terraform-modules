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

resource "azurerm_role_definition" "compute_gallery_role_definition" {
  name        = join("-", ["ComputeGalleryWriter", var.sig_application_name])
  scope       = var.resource_group_id
  description = var.role_definition_description

  permissions {
    actions = [
      "Microsoft.Compute/galleries/read",
      "Microsoft.Compute/galleries/images/read",
      "Microsoft.Compute/galleries/images/versions/read",
      "Microsoft.Compute/galleries/images/versions/write",

      "Microsoft.Compute/images/write",
      "Microsoft.Compute/images/read",
      "Microsoft.Compute/images/delete"
    ]

    not_actions = []
  }
  
  assignable_scopes = var.assignable_scopes
}

resource "azurerm_user_assigned_identity" "compute_gallery_user_assigned_identity" {
  resource_group_name = var.resource_group
  location            = var.location
  name                = var.user_assigned_identity_name
}

resource "azurerm_role_assignment" "compute_gallery_role_assignment" {
  scope              = var.resource_group_id
  role_definition_id = azurerm_role_definition.compute_gallery_role_definition.role_definition_resource_id
  principal_id       = azurerm_user_assigned_identity.compute_gallery_user_assigned_identity.principal_id
  depends_on = [
    azurerm_role_definition.compute_gallery_role_definition,
    azurerm_user_assigned_identity.compute_gallery_user_assigned_identity
  ]
}
