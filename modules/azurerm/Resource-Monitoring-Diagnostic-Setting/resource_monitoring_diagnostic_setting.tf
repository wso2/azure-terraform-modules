# -------------------------------------------------------------------------------------
#
# Copyright (c) 2024, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
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

data "azurerm_monitor_diagnostic_categories" "default" {
  resource_id = var.sub_service_id != "" ? "${var.target_resource_id}/${var.sub_service_id}" : var.target_resource_id
}

resource "azurerm_monitor_diagnostic_setting" "resource_monitoring_diagnostic_setting" {
  name                           = var.log_setting_name
  target_resource_id             = var.sub_service_id != "" ? "${var.target_resource_id}/${var.sub_service_id}" : var.target_resource_id
  log_analytics_workspace_id     = var.archival_locations.log_analytics_workspace_id != "" ? var.archival_locations.log_analytics_workspace_id : null
  storage_account_id             = var.archival_locations.archival_storage_account_id != "" ? var.archival_locations.archival_storage_account_id : null
  log_analytics_destination_type = var.log_analytics_destination_type

  dynamic "log" {
    for_each = local.all_logs_settings
    content {
      category = log.key
      enabled  = log.value
    }
  }

  dynamic "metric" {
    for_each = local.all_metrics_settings
    content {
      category = metric.key
      enabled  = metric.value

    }
  }
}
