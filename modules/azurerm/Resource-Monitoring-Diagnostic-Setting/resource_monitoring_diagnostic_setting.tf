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
      enabled  = log.value == 0 ? false : true

      # Only applies to Archived logs sent to storage
      retention_policy {
        enabled = log.value == 0 ? false : true
        days    = log.value
      }
    }
  }

  dynamic "metric" {
    for_each = local.all_metrics_settings
    content {
      category = metric.key
      enabled  = metric.value == 0 ? false : true

      # Only applies to Archived logs sent to storage
      retention_policy {
        enabled = metric.value == 0 ? false : true
        days    = metric.value
      }
    }
  }
}
