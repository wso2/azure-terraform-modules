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

data "local_file" "powershell_script" {
  filename = var.filepath
}

resource "azurerm_automation_runbook" "automation_runbook" {
  name                    = join("-", ["ar", var.project, var.environment, var.automation_runbook_name])
  location                = var.location
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  runbook_type            = var.runbook_type
  log_verbose             = var.log_verbose
  log_progress            = var.log_progress
  content                 = data.local_file.powershell_script.content
  tags = var.tags
  depends_on = [
    data.local_file.powershell_script
  ]

  publish_content_link {
    uri = var.uri
  }
}
