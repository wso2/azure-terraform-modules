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

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "scheduled_query_rules_alert" {
  for_each             = var.query_rules_alert
  name                 = join("-", ["sqra", each.value.alert_name])
  location             = var.location
  resource_group_name  = var.resource_group_name
  scopes               = each.value.scope_list
  description          = each.value.description
  enabled              = each.value.query_enabled
  severity             = each.value.severity
  evaluation_frequency = each.value.evaluation_frequency
  window_duration      = each.value.window_duration
  tags                 = merge(var.tags, { "enabled" : each.value.query_enabled })

  action {
    action_groups = each.value.action_group_id_list
  }

  criteria {
    operator                = each.value.operator
    query                   = each.value.query
    threshold               = each.value.threshold
    time_aggregation_method = each.value.time_aggregation_method

    dynamic "dimension" {
      for_each = (each.value.dimension != null) ? each.value.dimension : null

      content {
        name     = dimension.value.name
        operator = dimension.value.operator
        values   = dimension.value.values
      }
    }

    dynamic "failing_periods" {
      for_each = (each.value.failing_periods != null) ? each.value.failing_periods : null

      content {
        minimum_failing_periods_to_trigger_alert = failing_periods.value.minimum_failing_periods_to_trigger_alert
        number_of_evaluation_periods             = failing_periods.value.number_of_evaluation_periods
      }
    }

    metric_measure_column = each.value.metric_measure_column
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "count_trigger_scheduled_query_rules_alert" {
  for_each             = var.count_trigger_query_rules_alert
  name                 = join("-", ["sqra", each.value.alert_name])
  location             = var.location
  resource_group_name  = var.resource_group_name
  scopes               = each.value.scope_list
  description          = each.value.description
  enabled              = each.value.query_enabled
  severity             = each.value.severity
  evaluation_frequency = each.value.evaluation_frequency
  window_duration      = each.value.window_duration
  tags                 = merge(var.tags, { "enabled" : each.value.query_enabled })

  action {
    action_groups = each.value.action_group_id_list
  }

  criteria {
    operator                = each.value.operator
    query                   = each.value.query
    threshold               = each.value.threshold
    time_aggregation_method = "Count"
  }
}
