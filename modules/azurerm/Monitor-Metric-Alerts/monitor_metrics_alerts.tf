# -------------------------------------------------------------------------------------
#
# Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------
resource "azurerm_monitor_metric_alert" "monitor_metric_alert_with_2_dimensions" {
  for_each             = var.metric_alerts_with_2_dimensions
  name                 = join("-", ["ma", var.project, each.value.reason, var.environment, var.padding])
  resource_group_name  = var.resource_group_name
  tags                 = var.default_tags
  scopes               = each.value.scopes
  description          = each.value.description
  frequency            = each.value.frequency
  severity             = each.value.severity
  target_resource_type = each.value.target_resource_type
  window_size          = each.value.window_size
  enabled              = var.alert_enabled
  criteria {
    metric_namespace = each.value.criteria_metric_namespace
    metric_name      = each.value.criteria_metric_name
    aggregation      = each.value.criteria_aggregation
    operator         = each.value.criteria_operator
    threshold        = each.value.criteria_threshold
    dimension {
      name     = each.value.dimension_1_name
      operator = each.value.dimension_1_operator
      values   = each.value.dimension_1_values
    }
    dimension {
      name     = each.value.dimension_2_name
      operator = each.value.dimension_2_operator
      values   = each.value.dimension_2_values
    }
  }

  action {
    action_group_id = each.value.monitor_action_group_id
  }
}

resource "azurerm_monitor_metric_alert" "monitor_metric_alert_with_1_dimension" {
  for_each             = var.metric_alerts_with_1_dimension
  name                 = join("-", ["ma", var.project, each.value.reason, var.environment, var.padding])
  resource_group_name  = var.resource_group_name
  tags                 = var.default_tags
  scopes               = each.value.scopes
  description          = each.value.description
  frequency            = each.value.frequency
  severity             = each.value.severity
  target_resource_type = each.value.target_resource_type
  window_size          = each.value.window_size
  enabled              = var.alert_enabled
  criteria {
    metric_namespace = each.value.criteria_metric_namespace
    metric_name      = each.value.criteria_metric_name
    aggregation      = each.value.criteria_aggregation
    operator         = each.value.criteria_operator
    threshold        = each.value.criteria_threshold
    dimension {
      name     = each.value.dimension_1_name
      operator = each.value.dimension_1_operator
      values   = each.value.dimension_1_values
    }
  }

  action {
    action_group_id = each.value.monitor_action_group_id
  }
}

resource "azurerm_monitor_metric_alert" "monitor_metric_alert" {
  for_each                 = var.metric_alerts
  name                     = join("-", ["ma", var.project, each.value.reason, var.environment, var.padding])
  resource_group_name      = var.resource_group_name
  tags                     = var.default_tags
  scopes                   = each.value.scopes
  description              = each.value.description
  target_resource_location = var.location
  window_size          = each.value.window_size
  frequency            = each.value.frequency
  severity             = each.value.severity
  enabled              = var.alert_enabled
  criteria {
    metric_namespace = each.value.criteria_metric_namespace
    metric_name      = each.value.criteria_metric_name
    aggregation      = each.value.criteria_aggregation
    operator         = each.value.criteria_operator
    threshold        = each.value.criteria_threshold
  }

  action {
    action_group_id = each.value.monitor_action_group_id
  }
}
