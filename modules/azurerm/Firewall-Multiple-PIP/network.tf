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

resource "azurerm_subnet" "firewall_subnet" {
  name                                      = "AzureFirewallSubnet"
  resource_group_name                       = var.resource_group_name
  virtual_network_name                      = var.virtual_network_name
  address_prefixes                          = [var.subnet_address_prefixes]
  private_endpoint_network_policies_enabled = var.firewall_subnet_enforce_private_link_endpoint_network_policies
}
