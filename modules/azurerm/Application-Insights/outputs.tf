# -------------------------------------------------------------------------------------
#
# Copyright (c) 2020, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

output "application_insights_id" {
  value = azurerm_application_insights.application_insights.id
}

output "application_insights_name" {
  value = azurerm_application_insights.application_insights.name
}

output "app_id" {
  value = azurerm_application_insights.application_insights.app_id
}

output "app_insights_instrumentation_key" {
  depends_on = [azurerm_application_insights.application_insights]
  value      = azurerm_application_insights.application_insights.instrumentation_key
}

output "app_insights_connecting_string" {
  depends_on = [azurerm_application_insights.application_insights]
  value      = azurerm_application_insights.application_insights.connection_string
}
