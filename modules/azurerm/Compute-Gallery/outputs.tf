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

output "compute_gallery_name" {
  value = azurerm_shared_image_gallery.compute_gallery.name
  depends_on = [azurerm_shared_image_gallery.compute_gallery]
}

output "compute_gallery_user_assigned_id" {
  value = azurerm_user_assigned_identity.compute_gallery_user_assigned_identity.id
  depends_on = [azurerm_user_assigned_identity.compute_gallery_user_assigned_identity]
}

output "compute_gallery_user_assigned_principal_id" {
  value = azurerm_user_assigned_identity.compute_gallery_user_assigned_identity.principal_id
  depends_on = [azurerm_user_assigned_identity.compute_gallery_user_assigned_identity]
}
