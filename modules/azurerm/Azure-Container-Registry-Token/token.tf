# -------------------------------------------------------------------------------------
#
# Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

resource "azurerm_container_registry_scope_map" "registry_scope_map" {
  name                    = "${var.scope_map_name}-scopemap"
  container_registry_name = var.container_registry_name
  resource_group_name     = var.resource_group_name
  actions                 = var.actions
}

resource "azurerm_container_registry_token" "registry_token" {
  name                    = "${var.scope_map_name}-token"
  container_registry_name = var.container_registry_name
  resource_group_name     = var.resource_group_name
  scope_map_id            = azurerm_container_registry_scope_map.registry_scope_map.id
}

resource "azurerm_container_registry_token_password" "registry_token_password" {
  container_registry_token_id = azurerm_container_registry_token.registry_token.id

  password1 {}
  password2 {}
}
