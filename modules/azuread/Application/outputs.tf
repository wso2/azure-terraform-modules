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

output "application_id" {
  value      = azuread_application.ad_application.application_id
  depends_on = [azuread_application.ad_application]
}

output "object_id" {
  value      = azuread_application.ad_application.object_id
  depends_on = [azuread_application.ad_application]
}
