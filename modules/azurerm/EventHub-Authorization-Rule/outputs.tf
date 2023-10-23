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

output "authorization_rule_primary_connection_string" {
  depends_on  = [azurerm_eventhub_authorization_rule.eventhub_authorization_rule]
  value       = azurerm_eventhub_authorization_rule.eventhub_authorization_rule.primary_connection_string
}

output "authorization_rule_secondary_connection_string" {
  depends_on  = [azurerm_eventhub_authorization_rule.eventhub_authorization_rule]
  value       = azurerm_eventhub_authorization_rule.eventhub_authorization_rule.secondary_connection_string
}
