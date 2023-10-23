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

resource "azurerm_app_service_plan" "app_service_plan" {
  name                = join("-", [var.resource_abbreviation, var.project, var.application_name, var.environment, var.padding])
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = var.app_service_plan_kind
  is_xenon            = var.app_service_plan_kind == "xenon" ? true : false
  reserved            = var.reserved
  tags                = var.default_tags
  per_site_scaling    = var.per_site_scaling
  zone_redundant      = var.zrs_enabled
  sku {
    tier      = var.tier
    size      = var.size
    capacity  = var.capacity
  }
}
