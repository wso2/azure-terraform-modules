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

resource "azurerm_automation_hybrid_runbook_worker_group" "hybrid_runbook_worker_group" {
  name                    = join("-", ["hwg", var.hybrid_worker_group_name])
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
}
