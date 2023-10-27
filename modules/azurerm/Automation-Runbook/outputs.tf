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

output "automation_runbook_id" {
  depends_on = [azurerm_automation_runbook.automation_runbook]
  value      = azurerm_automation_runbook.automation_runbook.id
}

output "automation_runbook_name" {
  depends_on = [azurerm_automation_runbook.automation_runbook]
  value      = azurerm_automation_runbook.automation_runbook.name
}
