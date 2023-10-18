# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

output "role_assignment_id" {
  depends_on = [azurerm_role_assignment.role_assignment_custom]
  value      = azurerm_role_assignment.role_assignment_custom.id
}

output "role_assignment_principal_type" {
  depends_on = [azurerm_role_assignment.role_assignment_custom]
  value      = azurerm_role_assignment.role_assignment_custom.principal_type
}
