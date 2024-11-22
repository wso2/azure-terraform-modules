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

resource "azurerm_monitor_scheduled_query_rules_alert" "scheduled_query_rules_alert" {
  for_each            = var.query_rules_alert
  name                = join("-", ["sqra", each.value.alert_name])
  location            = var.location
  resource_group_name = var.resource_group_name
  data_source_id      = each.value.log_analytics_workspace_id
  description         = each.value.description
  enabled             = each.value.query_enabled
  query               = each.value.query
  severity            = each.value.severity
  frequency           = each.value.frequency
  time_window         = each.value.time_window
  tags                = merge(var.tags, { "enabled" : each.value.query_enabled })

  action {
    action_group = each.value.action_group_id_list
  }

  trigger {
    operator  = each.value.operator
    threshold = each.value.threshold

    metric_trigger {
      operator            = each.value.metric_trigger_operator
      threshold           = each.value.metric_threshold
      metric_trigger_type = each.value.metric_trigger_type
      metric_column       = each.value.metric_column
    }
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "count_trigger_scheduled_query_rules_alert" {
  for_each            = var.count_trigger_query_rules_alert
  name                = join("-", ["sqra", each.value.alert_name])
  location            = var.location
  resource_group_name = var.resource_group_name
  data_source_id      = each.value.log_analytics_workspace_id
  description         = each.value.description
  enabled             = each.value.query_enabled
  query               = each.value.query
  severity            = each.value.severity
  frequency           = each.value.frequency
  time_window         = each.value.time_window
  tags                = merge(var.tags, { "enabled" : each.value.query_enabled })

  action {
    action_group = each.value.action_group_id_list
  }

  trigger {
    operator  = each.value.operator
    threshold = each.value.threshold
  }
}
