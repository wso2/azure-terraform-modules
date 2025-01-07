# -------------------------------------------------------------------------------------
#
# Copyright (c) 2025, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
#
# WSO2 LLC. licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the
# specific language governing permissions and limitations
# under the License.
#
# --------------------------------------------------------------------------------------

resource "azurerm_cdn_profile" "cdn_profile" {
  name                = join("-", ["cdnp", var.cdn_profile_name])
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.cdn_profile_sku
  tags                = var.tags
}

resource "azurerm_cdn_endpoint" "cdn_endpoint" {
  name                          = join("-", ["cdne", var.cdn_endpoint_name])
  profile_name                  = azurerm_cdn_profile.cdn_profile.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  origin_host_header            = azurerm_storage_account.static_storage.primary_web_host
  querystring_caching_behaviour = "IgnoreQueryString"
  tags                          = var.tags

  origin {
    name      = var.cdn_origin_name
    host_name = azurerm_storage_account.static_storage.primary_web_host
  }

  dynamic "delivery_rule" {
    for_each = var.cdn_delivery_rules
    content {
      name  = delivery_rule.value.name
      order = delivery_rule.value.order
      url_path_condition {
        match_values = delivery_rule.value.match_conditions
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
