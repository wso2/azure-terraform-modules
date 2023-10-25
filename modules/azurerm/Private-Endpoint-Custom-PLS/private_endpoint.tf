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

resource "azurerm_private_endpoint" "private_endpoint" {
  name                = join("-", ["pvtep", var.project, var.workload_name, var.environment, var.location, var.padding])
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id
  tags                = var.tags

  private_service_connection {
    name                              = var.private_link_service_connection_name
    private_connection_resource_alias = var.private_link_resource_alias
    is_manual_connection              = true
    request_message                   = var.connection_request_message
  }
}
