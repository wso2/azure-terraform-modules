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

resource "azurerm_log_analytics_data_export_rule" "log_analytics_data_export_rule" {
  name                    = var.log_analytics_data_export_rule_name
  resource_group_name     = var.resource_group_name
  workspace_resource_id   = var.workspace_resource_id
  destination_resource_id = var.destination_resource_id
  table_names             = var.table_names
  enabled                 = var.log_analytics_data_export_rule_enabled
}
