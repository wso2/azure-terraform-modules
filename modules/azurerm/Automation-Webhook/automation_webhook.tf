# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

resource "azurerm_automation_webhook" "automation_webhook" {
  name                    = var.automation_webhook_name
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  expiry_time             = var.automation_webhook_expiry_time
  enabled                 = var.automation_webhook_enabled
  runbook_name            = var.automation_runbook_name 
}
