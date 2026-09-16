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

output "application_id" {
  value = azuread_application_registration.ad_application.id
}

output "client_id" {
  value = azuread_application_registration.ad_application.client_id
}

output "object_id" {
  value = azuread_application_registration.ad_application.object_id
}

output "sp_internal_id" {
  value = azuread_service_principal.service_principal.id
}

output "sp_password" {
  value     = azuread_service_principal_password.service_principal_password.value
  sensitive = true
}

output "tier_group_ids" {
  description = "Object ID per tier - keys: nonprod-reader, nonprod-contributor, prod-contributor, prod-reader"
  value       = { for k, g in azuread_group.tier : k => g.object_id }
}
