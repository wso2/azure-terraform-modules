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
  name                = join("-", ["pvtep", var.private_endpoint_name])
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = join("-", ["pvtsc", var.private_endpoint_service_connection_name])
    private_connection_resource_id = var.private_connection_resource_id
    subresource_names              = var.subresource_names
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = join("-", ["pvtdns", private_endpoint_dns_zone_group_name])
    private_dns_zone_ids = var.private_dns_zone_ids
  }
}
