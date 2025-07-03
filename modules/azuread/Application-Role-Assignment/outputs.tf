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

output "client_id" {
  description = "The client ID of the Azure AD application."
  value       = azuread_application.ad_application.client_id
}

output "object_id" {
  description = "The object ID of the service principal."
  value       = azuread_service_principal.service_principal.object_id
}
