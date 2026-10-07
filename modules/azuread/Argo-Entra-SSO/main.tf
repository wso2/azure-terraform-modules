# -------------------------------------------------------------------------------------
#
# Copyright (c) 2026, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
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

resource "azuread_application_registration" "ad_application" {
  display_name            = var.application_name
  group_membership_claims = var.group_membership_claims

  lifecycle {
    create_before_destroy = true
  }
}

# A plain bool: count can't depend on redirect_uris, which may be unknown until apply.
resource "azuread_application_redirect_uris" "ad_application" {
  count = var.manage_redirect_uris ? 1 : 0

  application_id = azuread_application_registration.ad_application.id
  type           = var.redirect_uri_type
  redirect_uris  = var.redirect_uris
}

resource "azuread_service_principal" "service_principal" {
  client_id                    = azuread_application_registration.ad_application.client_id
  app_role_assignment_required = var.sp_app_role_assignment_required
}

resource "time_rotating" "password_rotating_time" {
  rotation_months = var.sp_password_rotation_months

  lifecycle {
    create_before_destroy = true
  }
}

resource "azuread_service_principal_password" "service_principal_password" {
  service_principal_id = azuread_service_principal.service_principal.id
  display_name         = var.sp_password_display_name

  rotate_when_changed = {
    rotation = time_rotating.password_rotating_time.id
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "azuread_group" "tier" {
  for_each = local.tier_groups

  display_name     = "${var.group_name_prefix}-${each.key}"
  description      = each.value
  security_enabled = true
}

# With app_role_assignment_required, only members of the tier groups can
# sign in at all. The all-zero ID is Entra's "default access" role, used
# when the application defines no app roles of its own.
resource "azuread_app_role_assignment" "tier" {
  for_each = var.sp_app_role_assignment_required ? local.tier_groups : {}

  app_role_id         = "00000000-0000-0000-0000-000000000000"
  principal_object_id = azuread_group.tier[each.key].object_id
  resource_object_id  = azuread_service_principal.service_principal.object_id
}

# Keeps the secret ESO syncs in step with rotation: the new password and
# the vault entry change in the same apply.
resource "azurerm_key_vault_secret" "client_secret" {
  count = var.store_client_secret_in_key_vault ? 1 : 0

  name         = var.client_secret_name
  value        = azuread_service_principal_password.service_principal_password.value
  key_vault_id = var.client_secret_key_vault_id
}

