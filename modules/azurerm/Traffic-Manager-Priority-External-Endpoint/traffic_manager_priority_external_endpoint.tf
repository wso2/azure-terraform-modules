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

resource "azurerm_traffic_manager_external_endpoint" "priority_external_endpoint" {
  name       = var.endpoint_name
  profile_id = var.profile_id
  priority   = var.priority
  target     = var.target
  enabled    = var.enabled

  dynamic "custom_header" {
    for_each = var.custom_header_enabled ? [1] : []
    content {
      name  = var.header_name
      value = var.header_value
    }
  }
}
