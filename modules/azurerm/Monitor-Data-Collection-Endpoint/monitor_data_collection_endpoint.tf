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

resource "azurerm_monitor_data_collection_endpoint" "data_collection_endpoint" {
  name                          = join("-", ["dce", var.project, var.endpoint_name, var.environment, var.location, var.padding])
  resource_group_name           = var.resource_group_name
  location                      = var.location
  kind                          = var.kind
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.default_tags
}
