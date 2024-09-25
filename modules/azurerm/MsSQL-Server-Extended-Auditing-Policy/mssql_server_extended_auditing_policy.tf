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

resource "azurerm_mssql_server_extended_auditing_policy" "mssql_extended_auditing_policy" {
  server_id                  = var.mssql_server_id
  storage_endpoint           = var.mssql_storage_account_primary_blob_endpoint
  storage_account_access_key = var.mssql_storage_account_primary_access_key
  retention_in_days          = var.retention_in_days
  log_monitoring_enabled     = var.log_monitoring_enabled
}

resource "azurerm_mssql_database_extended_auditing_policy" "mssql_database_log_analytics_extended_auditing_policy" {
  count                  = var.mssql_master_database_auditing_policy_enabled ? 1 : 0
  database_id            = "${var.mssql_server_id}/databases/master"
  log_monitoring_enabled = var.log_monitoring_enabled
}
