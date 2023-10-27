# -------------------------------------------------------------------------------------
#
# Copyright (c) 2023, WSO2 LLC (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

output "workbook_id" {
  depends_on = [azurerm_application_insights_workbook.application_insights_workbook]
  value      = azurerm_application_insights_workbook.application_insights_workbook.id
}

output "workbook_name" {
  depends_on = [azurerm_application_insights_workbook.application_insights_workbook]
  value      = azurerm_application_insights_workbook.application_insights_workbook.name
}

output "workbook_display_name" {
  depends_on = [azurerm_application_insights_workbook.application_insights_workbook]
  value      = azurerm_application_insights_workbook.application_insights_workbook.display_name
}
