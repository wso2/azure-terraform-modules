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

resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = var.loadbalancer_id

  dynamic "rule_configuration" {
    for_each = var.rule_configuration

    content {
      name                           = rule_configuration.value["name"]
      frontend_ip_configuration_name = rule_configuration.value["frontend_ip_configuration_name"]
      protocol                       = rule_configuration.value["protocol"]
      frontend_port                  = rule_configuration.value["frontend_port"]
      backend_port                   = rule_configuration.value["backend_port"]
      backend_address_pool_ids       = rule_configuration.value["backend_address_pool_ids"]
    }
  }
}
