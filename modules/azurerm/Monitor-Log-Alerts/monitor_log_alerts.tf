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

resource "azurerm_monitor_activity_log_alert" "monitor_recommendation_alert" {
  for_each            = var.recommendation_alerts
  tags                = var.tags
  name                = join("-", ["ala", var.project, each.value.reason, var.environment, var.padding])
  resource_group_name = var.resource_group_name
  scopes              = each.value.scopes
  description         = each.value.description
  enabled             = var.alert_enabled

  criteria {
    category              = "Recommendation"
    recommendation_impact = each.value.recommendation_impact
  }

  action {
    action_group_id = each.value.monitor_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "monitor_activity_log_alert" {
  for_each            = var.activity_log_alerts
  tags                = var.tags
  name                = join("-", ["ala", var.project, each.value.reason, var.environment, var.padding])
  resource_group_name = var.resource_group_name
  scopes              = each.value.scopes
  description         = each.value.description
  enabled             = var.alert_enabled

  criteria {
    category = each.value.criteriaCategory
    level    = each.value.criteriaLevel
  }

  action {
    action_group_id = each.value.monitor_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "monitor_resource_health_alert" {
  for_each            = var.resource_health_alerts
  tags                = var.tags
  name                = join("-", ["ala", var.project, each.value.reason, var.environment, var.padding])
  resource_group_name = var.resource_group_name
  scopes              = each.value.scopes
  enabled             = each.value.query_enabled
  description         = each.value.description

  criteria {
    category       = each.value.criteriaCategory
    level          = each.value.criteriaLevel
    resource_group = each.value.target_resource_group
    resource_type  = each.value.target_resource_type
    resource_id    = each.value.target_resource_id
    status         = each.value.status
    resource_health {
      current  = each.value.currentStatuses
      previous = each.value.previousStatuses
      reason   = each.value.criteriaReason
    }
  }

  action {
    action_group_id = each.value.monitor_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "monitor_service_health_alert" {
  for_each            = var.service_health_alerts
  tags                = var.tags
  name                = join("-", ["ala", var.project, each.value.reason, var.environment, var.padding])
  resource_group_name = var.resource_group_name
  scopes              = each.value.scopes
  enabled             = each.value.query_enabled
  description         = each.value.description

  criteria {
    category = each.value.criteriaCategory
    level    = each.value.criteriaLevel
    service_health {
      locations = each.value.targetLocations
      events    = each.value.targetEvents
    }
  }

  action {
    action_group_id = each.value.monitor_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "monitor_specific_service_health_alert" {
  for_each            = var.specific_service_health_alerts
  tags                = var.tags
  name                = join("-", ["ala", var.project, each.value.reason, var.environment, var.padding])
  resource_group_name = var.resource_group_name
  scopes              = each.value.scopes
  enabled             = each.value.query_enabled
  description         = each.value.description

  criteria {
    category = each.value.criteriaCategory
    service_health {
      locations = each.value.targetLocations
      events    = each.value.targetEvents
      services  = each.value.targetServices
    }
  }

  action {
    action_group_id = each.value.monitor_action_group_id
  }
}
