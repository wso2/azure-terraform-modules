# -------------------------------------------------------------------------------------
#
# Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

resource "azurerm_monitor_alert_processing_rule_suppression" "monitor_alert_processing_rule_suppression" {
  name                = join("-", ["apr", var.monitor_alert_processing_rule_suppression_name])
  resource_group_name = var.resource_group_name
  description         = var.description
  scopes              = var.scopes
  enabled             = var.enabled
  tags                = var.tags

  condition {
    monitor_condition {
      operator = var.operator
      values   = var.values
    }
  }
}
