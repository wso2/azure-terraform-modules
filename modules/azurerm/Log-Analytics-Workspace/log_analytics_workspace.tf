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

resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                       = join("-", ["log", var.log_analytics_workspace_name])
  location                   = var.location
  resource_group_name        = var.resource_group_name
  sku                        = var.log_analytics_workspace_sku
  retention_in_days          = var.log_retention_in_days
  daily_quota_gb             = var.daily_quota_gb
  internet_ingestion_enabled = var.internet_ingestion_enabled
  internet_query_enabled     = var.internet_query_enabled
  tags                       = var.tags
}
