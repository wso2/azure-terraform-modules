# -------------------------------------------------------------------------------------
#
# Copyright (c) 2025, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
#
# WSO2 LLC. licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the
# specific language governing permissions and limitations
# under the License.
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
