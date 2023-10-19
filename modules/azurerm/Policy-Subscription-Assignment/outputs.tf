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
output "id" {
  depends_on = [azurerm_subscription_policy_assignment.subscription_policy_assignment]
  value      = azurerm_subscription_policy_assignment.subscription_policy_assignment.id
}

output "identity_principal_id" {
  value = azurerm_subscription_policy_assignment.subscription_policy_assignment.identity[0].principal_id
}
