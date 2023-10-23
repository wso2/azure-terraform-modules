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


resource "azurerm_key_vault_access_policy" "key_vault_access_policy" {
  key_vault_id            = var.key_vault_id
  tenant_id               = var.vault_access_tenant_id
  object_id               = var.vault_access_object_id
  secret_permissions      = var.vault_access_secret_permissions
  certificate_permissions = var.vault_access_certificate_permissions
  key_permissions         = var.vault_access_key_permissions
  storage_permissions     = var.vault_access_storage_permissions
}
