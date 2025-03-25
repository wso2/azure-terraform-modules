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

resource "azurerm_monitor_activity_log_alert" "monitor_activity_log_administrative_alert" {
  for_each            = var.activity_log_administrative_alerts
  tags                = var.tags
  name                = join("-", [var.monitor_activity_log_alert_abbreviation, each.value.monitor_activity_log_alert_name])
  resource_group_name = var.resource_group_name
  scopes              = each.value.scopes
  description         = each.value.description
  enabled             = var.alert_enabled
  location            = each.value.location

  criteria {
    resource_id    = each.value.resource_id
    operation_name = each.value.operation_name
    category       = each.value.category
  }

  action {
    action_group_id = each.value.monitor_action_group_id
  }
}
