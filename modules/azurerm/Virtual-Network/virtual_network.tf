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

resource "azurerm_virtual_network" "virtual_network" {
  name                = var.network_mode != "" ? join("-", ["vnet", var.project, var.network_mode, var.application_name, var.environment, var.location, var.padding]) : join("-", ["vnet", var.project, var.application_name, var.environment, var.location, var.padding])
  address_space       = [var.virtual_network_address_space]
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = var.tags

  dynamic "ddos_protection_plan" {
    for_each = var.ddos_protection_plan_id == "" ? [] : [var.ddos_protection_plan_id]

    content {
      id     = var.ddos_protection_plan_id
      enable = var.ddos_protection_plan_enable
    }
  }
}
