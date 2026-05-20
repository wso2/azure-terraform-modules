# -------------------------------------------------------------------------------------
#
# Copyright (c) 2026, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
#
# WSO2 LLC. licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the
# specific language governing permissions and limitations
# under the License.
#
# --------------------------------------------------------------------------------------

resource "azurerm_monitor_scheduled_query_rules_alert" "scheduled_query_rules_alert" {
  for_each            = var.query_rules_alert
  name                = join("-", compact([var.scheduled_query_alert_abbreviation, each.value.alert_name]))
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
    action_group           = each.value.action_group_id_list
    custom_webhook_payload = each.value.custom_webhook_payload
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
  name                = join("-", compact([var.scheduled_query_alert_abbreviation, each.value.alert_name]))
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
    action_group           = each.value.action_group_id_list
    custom_webhook_payload = each.value.custom_webhook_payload
  }

  trigger {
    operator  = each.value.operator
    threshold = each.value.threshold
  }
}
