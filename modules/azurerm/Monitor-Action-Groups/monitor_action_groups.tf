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

resource "azurerm_monitor_action_group" "monitor_action_group" {
  name                = join("-", [var.monitor_action_group_abbreviation, var.montior_action_group_name])
  resource_group_name = var.resource_group_name
  short_name          = var.short_name
  tags                = var.tags

  dynamic "email_receiver" {
    for_each = var.email_receivers

    content {
      name                    = email_receiver.value.name
      email_address           = email_receiver.value.email_address
      use_common_alert_schema = email_receiver.value.use_common_alert_schema
    }
  }

  dynamic "webhook_receiver" {
    for_each = var.actions_webhook_critical

    content {
      name                    = webhook_receiver.value.name
      service_uri             = webhook_receiver.value.service_uri
      use_common_alert_schema = webhook_receiver.value.use_common_alert_schema
    }
  }

  dynamic "automation_runbook_receiver" {
    for_each = var.automation_runbooks

    content {
      name                    = automation_runbook_receiver.value.name
      automation_account_id   = automation_runbook_receiver.value.automation_account_id
      runbook_name            = automation_runbook_receiver.value.runbook_name
      webhook_resource_id     = automation_runbook_receiver.value.webhook_resource_id
      is_global_runbook       = automation_runbook_receiver.value.is_global_runbook
      service_uri             = automation_runbook_receiver.value.service_uri
      use_common_alert_schema = automation_runbook_receiver.value.use_common_alert_schema
    }
  }
}
