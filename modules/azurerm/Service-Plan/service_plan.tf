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

resource "azurerm_service_plan" "service_plan" {
  name                = join("-", ["asp", var.project, var.application_name, var.environment, var.padding])
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = var.os_type
  sku_name            = var.sku_name

  zone_balancing_enabled       = var.availability_zone_enabled
  maximum_elastic_worker_count = var.maximum_elastic_worker_count
  worker_count                 = var.worker_count

  tags = var.default_tags
}
