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

resource "azurerm_cdn_endpoint" "cdn_endpoint" {
  name                          = join("-", ["cdne", local.cdne_name_without_prefix])
  profile_name                  = var.cdn_profile_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  origin_host_header            = var.origin_host_header
  querystring_caching_behaviour = var.querystring_caching_behaviour
  tags                          = var.cdne_tags
  origin {
    name      = var.origin_name
    host_name = var.origin_host_name
  }

  dynamic "delivery_rule" {
    for_each = var.cdn_delivery_rules
    content {
      name  = delivery_rule.value.name
      order = delivery_rule.value.order
      url_path_condition {
        match_values = delivery_rule.value.match_condition
        operator     = delivery_rule.value.operator
      }

      url_redirect_action {
        hostname      = delivery_rule.value.hostname
        path          = delivery_rule.value.path
        protocol      = delivery_rule.value.protocol
        redirect_type = delivery_rule.value.redirect_type
      }
    }
  }
}
