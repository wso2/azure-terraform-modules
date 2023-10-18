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

output "log_analytics_workspace_name" {
  depends_on = [azurerm_log_analytics_workspace.log_analytics_workspace]
  value      = azurerm_log_analytics_workspace.log_analytics_workspace.name
}

output "log_analytics_workspace_id" {
  depends_on = [azurerm_log_analytics_workspace.log_analytics_workspace]
  value      = azurerm_log_analytics_workspace.log_analytics_workspace.id
}

output "primary_shared_key" {
  depends_on = [azurerm_log_analytics_workspace.log_analytics_workspace]
  value      = azurerm_log_analytics_workspace.log_analytics_workspace.primary_shared_key
}

output "workspace_id" {
  depends_on = [azurerm_log_analytics_workspace.log_analytics_workspace]
  value      = azurerm_log_analytics_workspace.log_analytics_workspace.workspace_id
}
