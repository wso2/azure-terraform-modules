# -------------------------------------------------------------------------------------
#
# Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

output "primary_api_operation_id" {
  value      = azurerm_api_management_api_operation.api_management_api_operation_primary.id
  depends_on = [azurerm_api_management_api_operation.api_management_api_operation_primary]
}

output "primary_api_operation_policy_id" {
  value      = azurerm_api_management_api_operation_policy.api_management_api_operation_policy_primary.id
  depends_on = [azurerm_api_management_api_operation_policy.api_management_api_operation_policy_primary]
}

output "secondary_api_operation_id" {
  value      = azurerm_api_management_api_operation.api_management_api_operation_secondary.id
  depends_on = [azurerm_api_management_api_operation.api_management_api_operation_secondary]
}

output "secondary_api_operation_policy_id" {
  value      = azurerm_api_management_api_operation_policy.api_management_api_operation_policy_secondary.id
  depends_on = [azurerm_api_management_api_operation_policy.api_management_api_operation_policy_secondary]
}
