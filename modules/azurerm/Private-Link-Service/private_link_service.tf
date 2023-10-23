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

resource "azurerm_private_link_service" "private_link_service" {
  name                = join("-",["pls", var.project, var.application_name , var.environment, var.location , var.padding ])
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.default_tags
  auto_approval_subscription_ids              = var.auto_approved_consumer_subscription_ids
  visibility_subscription_ids                 = var.visible_consumer_subscription_ids
  load_balancer_frontend_ip_configuration_ids = var.frontend_ip_config_ids

  dynamic "nat_ip_configuration" {
    for_each = var.nat_ip_configurations
    content {
      name = nat_ip_configuration.value.name
      primary = nat_ip_configuration.value.primary
      subnet_id = nat_ip_configuration.value.subnet_id
      private_ip_address = nat_ip_configuration.value.private_ip_address
    }
  }
}
