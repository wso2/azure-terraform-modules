# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 LLC (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

resource "random_uuid" "random_uuid_worker_id" {
}

resource "azurerm_automation_hybrid_runbook_worker" "hybrid_runbook_worker" {
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  worker_group_name       = var.worker_group_name
  vm_resource_id          = var.vm_resource_id
  worker_id               = random_uuid.random_uuid_worker_id.id
}
