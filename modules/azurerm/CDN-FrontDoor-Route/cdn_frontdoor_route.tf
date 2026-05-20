# -------------------------------------------------------------------------------------
#
# Copyright (c) 2024, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
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

resource "azurerm_cdn_frontdoor_route" "cdn_frontdoor_route" {
  name                          = var.route_name
  cdn_frontdoor_endpoint_id     = var.cdn_frontdoor_endpoint_id
  cdn_frontdoor_origin_group_id = var.cdn_frontdoor_origin_group_id
  cdn_frontdoor_origin_ids      = var.cdn_frontdoor_origin_ids
  cdn_frontdoor_rule_set_ids    = var.cdn_frontdoor_rule_set_ids
  enabled                       = var.enable_route

  forwarding_protocol    = var.forwarding_protocol
  https_redirect_enabled = var.https_redirect_enabled
  patterns_to_match      = var.patterns_to_match
  supported_protocols    = var.supported_protocols

  cdn_frontdoor_custom_domain_ids = var.cdn_frontdoor_custom_domain_ids
  link_to_default_domain          = var.link_to_default_domain
  cdn_frontdoor_origin_path       = var.cdn_frontdoor_origin_path

  dynamic "cache" {
    for_each = var.enable_cache == true ? ["cache"] : []
    content {
      query_string_caching_behavior = var.cache_query_string_caching_behavior
      query_strings                 = var.cache_query_strings
      compression_enabled           = var.cache_compression_enabled
      content_types_to_compress     = var.cache_content_types_to_compress
    }
  }
}
