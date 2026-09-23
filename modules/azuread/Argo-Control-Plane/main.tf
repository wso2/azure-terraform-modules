# -------------------------------------------------------------------------------------
#
# Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------
#
# Everything the Argo control plane's Entra ID SSO needs, self-contained
# in one module: the app registration, its service principal + rotating
# password, and the RBAC tier groups credential-injector maps requests
# against.
#
# --------------------------------------------------------------------------------------

resource "azuread_application_registration" "ad_application" {
  display_name            = var.application_name
  group_membership_claims = var.group_membership_claims

  lifecycle {
    create_before_destroy = true
  }
}

# Gated on var.manage_redirect_uris (a plain bool), not
# length(var.redirect_uris) - count/for_each can't depend on a value
# that's only known after apply, and redirect_uris often is one.
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
