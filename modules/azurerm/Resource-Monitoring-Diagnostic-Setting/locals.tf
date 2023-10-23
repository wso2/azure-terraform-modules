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

locals {
  user_provided_logs_settings    = { for s in var.required_log_categories : s.category_name => s.retention_period }
  user_provided_metrics_settings = { for s in var.required_metric_categories : s.category_name => s.retention_period }

  default_logs_retention_period = var.all_log_types_enabled.enabled ? var.all_log_types_enabled.retention_period : 0

  default_metrics_retention_period = var.all_metrics_enabled.enabled ? var.all_metrics_enabled.retention_period : 0
  updated_default_logs_settings    = { for s in sort(data.azurerm_monitor_diagnostic_categories.default.logs) : s => local.default_logs_retention_period }
  updated_default_metrics_settings = { for s in sort(data.azurerm_monitor_diagnostic_categories.default.metrics) : s => local.default_metrics_retention_period }
  all_logs_settings                = merge(local.updated_default_logs_settings, local.user_provided_logs_settings)
  all_metrics_settings             = merge(local.updated_default_metrics_settings, local.user_provided_metrics_settings)
}
