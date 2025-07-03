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

resource "azuread_application" "ad_application" {
  display_name = var.application_name
  description  = var.description
  owners       = var.owners

  dynamic "required_resource_access" {
    for_each = var.required_resource_access_map
    content {
      resource_app_id = required_resource_access.key

      dynamic "resource_access" {
        for_each = required_resource_access.value
        content {
          id   = resource_access.key
          type = resource_access.value
        }
      }
    }
  }
}

resource "azuread_service_principal" "service_principal" {
  client_id  = azuread_application.ad_application.client_id
  depends_on = [azuread_application.ad_application]
}

resource "azurerm_role_assignment" "role_assignment" {
  for_each             = var.role_assignments
  scope                = each.value.scope
  role_definition_name = each.value.role_definition_name
  principal_id         = azuread_service_principal.service_principal.object_id
  depends_on           = [azuread_service_principal.service_principal]
}

resource "azurerm_role_definition" "custom_role" {
  for_each = var.custom_role_definitions

  name        = each.value.name
  description = each.value.description
  scope       = each.value.scope

  permissions {
    actions = each.value.permissions
  }
}

resource "azurerm_role_assignment" "custom_role_assignment" {
  for_each           = var.custom_role_definitions
  scope              = each.value.scope
  role_definition_id = azurerm_role_definition.custom_role[each.key].role_definition_resource_id
  principal_id       = azuread_service_principal.service_principal.object_id
  depends_on         = [azuread_service_principal.service_principal]
}
