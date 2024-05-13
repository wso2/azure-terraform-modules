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

locals {
  user_provided_logs_settings      = { for s in var.required_log_categories : s.category_name => true }
  user_provided_metrics_settings   = { for s in var.required_metric_categories : s.category_name => true }
  updated_default_logs_settings    = { for s in sort(data.azurerm_monitor_diagnostic_categories.default.logs) : s => var.all_log_types_enabled }
  updated_default_metrics_settings = { for s in sort(data.azurerm_monitor_diagnostic_categories.default.metrics) : s => var.all_metrics_enabled }
  all_logs_settings                = merge(local.updated_default_logs_settings, local.user_provided_logs_settings)
  all_metrics_settings             = merge(local.updated_default_metrics_settings, local.user_provided_metrics_settings)
}
