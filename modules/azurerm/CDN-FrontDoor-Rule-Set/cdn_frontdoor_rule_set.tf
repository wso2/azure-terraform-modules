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

resource "azurerm_cdn_frontdoor_rule_set" "cdn_frontdoor_rule_set" {
  name                     = var.rule_set_name
  cdn_frontdoor_profile_id = var.cdn_frontdoor_profile_id
}

resource "azurerm_cdn_frontdoor_rule" "cdn_frontdoor_rule" {
  for_each                  = var.rules
  name                      = each.key
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.cdn_frontdoor_rule_set.id
  order                     = each.value.order
  behavior_on_match         = each.value.behavior_on_match

  actions {
    dynamic "url_rewrite_action" {
      for_each = each.value.url_rewrite_actions
      content {
        source_pattern          = url_rewrite_action.value.source_pattern
        destination             = url_rewrite_action.value.destination
        preserve_unmatched_path = url_rewrite_action.value.preserve_unmatched_path
      }
    }

    dynamic "url_redirect_action" {
      for_each = each.value.url_redirect_actions
      content {
        redirect_type        = url_redirect_action.value.redirect_type
        destination_hostname = url_redirect_action.value.destination_hostname
        redirect_protocol    = url_redirect_action.value.redirect_protocol
        destination_path     = url_redirect_action.value.destination_path
        query_string         = url_redirect_action.value.query_string
        destination_fragment = url_redirect_action.value.destination_fragment
      }
    }

    dynamic "route_configuration_override_action" {
      for_each = each.value.route_configuration_override_actions
      content {
        cache_duration                = route_configuration_override_action.value.cache_duration
        cdn_frontdoor_origin_group_id = route_configuration_override_action.value.cdn_frontdoor_origin_group_id
        forwarding_protocol           = route_configuration_override_action.value.forwarding_protocol
        query_string_caching_behavior = route_configuration_override_action.value.query_string_caching_behavior
        query_string_parameters       = route_configuration_override_action.value.query_string_parameters
        compression_enabled           = route_configuration_override_action.value.compression_enabled
        cache_behavior                = route_configuration_override_action.value.cache_behavior
      }
    }

    dynamic "request_header_action" {
      for_each = each.value.request_header_actions
      content {
        header_action = request_header_action.value.header_action
        header_name   = request_header_action.value.header_name
        value         = request_header_action.value.value
      }
    }

    dynamic "response_header_action" {
      for_each = each.value.response_header_actions
      content {
        header_action = response_header_action.value.header_action
        header_name   = response_header_action.value.header_name
        value         = response_header_action.value.value
      }
    }
  }

  conditions {
    dynamic "remote_address_condition" {
      for_each = { for k, v in each.value.conditions : k => v if v.type == "remote_address" }
      content {
        match_values     = remote_address_condition.value.match_values
        operator         = remote_address_condition.value.operator
        negate_condition = remote_address_condition.value.negate_condition
      }
    }

    dynamic "request_method_condition" {
      for_each = { for k, v in each.value.conditions : k => v if v.type == "request_method" }
      content {
        match_values     = request_method_condition.value.match_values
        operator         = request_method_condition.value.operator
        negate_condition = request_method_condition.value.negate_condition
      }
    }

    dynamic "query_string_condition" {
      for_each = { for k, v in each.value.conditions : k => v if v.type == "query_string" }
      content {
        match_values     = query_string_condition.value.match_values
        operator         = query_string_condition.value.operator
        negate_condition = query_string_condition.value.negate_condition
        transforms       = query_string_condition.value.transforms
      }
    }

    dynamic "post_args_condition" {
      for_each = { for k, v in each.value.conditions : k => v if v.type == "post_args" }
      content {
        post_args_name   = post_args_condition.value.object_name
        match_values     = post_args_condition.value.match_values
        operator         = post_args_condition.value.operator
        negate_condition = post_args_condition.value.negate_condition
        transforms       = post_args_condition.value.transforms
      }
    }

    dynamic "request_uri_condition" {
      for_each = { for k, v in each.value.conditions : k => v if v.type == "request_uri" }
      content {
        match_values     = request_uri_condition.value.match_values
        operator         = request_uri_condition.value.operator
        negate_condition = request_uri_condition.value.negate_condition
        transforms       = request_uri_condition.value.transforms
      }
    }

    dynamic "request_header_condition" {
      for_each = { for k, v in each.value.conditions : k => v if v.type == "request_header" }
      content {
        match_values     = request_header_condition.value.match_values
        operator         = request_header_condition.value.operator
        negate_condition = request_header_condition.value.negate_condition
        transforms       = request_header_condition.value.transforms
        header_name      = request_header_condition.value.object_name
      }
    }

    dynamic "request_body_condition" {
      for_each = { for k, v in each.value.conditions : k => v if v.type == "request_body" }
      content {
        match_values     = request_body_condition.value.match_values
        operator         = request_body_condition.value.operator
        negate_condition = request_body_condition.value.negate_condition
        transforms       = request_body_condition.value.transforms
      }
    }

    dynamic "request_scheme_condition" {
      for_each = { for k, v in each.value.conditions : k => v if v.type == "request_scheme" }
      content {
        match_values     = request_scheme_condition.value.match_values
        operator         = request_scheme_condition.value.operator
        negate_condition = request_scheme_condition.value.negate_condition
      }
    }

    dynamic "url_path_condition" {
      for_each = { for k, v in each.value.conditions : k => v if v.type == "url_path" }
      content {
        match_values     = url_path_condition.value.match_values
        operator         = url_path_condition.value.operator
        negate_condition = url_path_condition.value.negate_condition
        transforms       = url_path_condition.value.transforms
      }
    }

    dynamic "url_file_extension_condition" {
      for_each = { for k, v in each.value.conditions : k => v if v.type == "url_file_extension" }
      content {
        match_values     = url_file_extension_condition.value.match_values
        operator         = url_file_extension_condition.value.operator
        negate_condition = url_file_extension_condition.value.negate_condition
        transforms       = url_file_extension_condition.value.transforms
      }
    }

    dynamic "url_filename_condition" {
      for_each = { for k, v in each.value.conditions : k => v if v.type == "url_filename" }
      content {
        match_values     = url_filename_condition.value.match_values
        operator         = url_filename_condition.value.operator
        negate_condition = url_filename_condition.value.negate_condition
        transforms       = url_filename_condition.value.transforms
      }
    }

    dynamic "http_version_condition" {
      for_each = { for k, v in each.value.conditions : k => v if v.type == "http_version" }
      content {
        match_values     = http_version_condition.value.match_values
        operator         = http_version_condition.value.operator
        negate_condition = http_version_condition.value.negate_condition
      }
    }

    dynamic "cookies_condition" {
      for_each = { for k, v in each.value.conditions : k => v if v.type == "cookies" }
      content {
        match_values     = cookies_condition.value.match_values
        operator         = cookies_condition.value.operator
        negate_condition = cookies_condition.value.negate_condition
        transforms       = cookies_condition.value.transforms
        cookie_name      = cookies_condition.value.object_name
      }
    }

    dynamic "is_device_condition" {
      for_each = { for k, v in each.value.conditions : k => v if v.type == "is_device" }
      content {
        match_values     = is_device_condition.value.match_values
        operator         = is_device_condition.value.operator
        negate_condition = is_device_condition.value.negate_condition
      }
    }

    dynamic "socket_address_condition" {
      for_each = { for k, v in each.value.conditions : k => v if v.type == "socket_address" }
      content {
        match_values     = socket_address_condition.value.match_values
        operator         = socket_address_condition.value.operator
        negate_condition = socket_address_condition.value.negate_condition
      }
    }

    dynamic "client_port_condition" {
      for_each = { for k, v in each.value.conditions : k => v if v.type == "client_port" }
      content {
        match_values     = client_port_condition.value.match_values
        operator         = client_port_condition.value.operator
        negate_condition = client_port_condition.value.negate_condition
      }
    }

    dynamic "server_port_condition" {
      for_each = { for k, v in each.value.conditions : k => v if v.type == "server_port" }
      content {
        match_values     = server_port_condition.value.match_values
        operator         = server_port_condition.value.operator
        negate_condition = server_port_condition.value.negate_condition
      }
    }

    dynamic "host_name_condition" {
      for_each = { for k, v in each.value.conditions : k => v if v.type == "host_name" }
      content {
        match_values = host_name_condition.value.match_values
        operator     = host_name_condition.value.operator
        transforms   = host_name_condition.value.transforms
      }
    }

    dynamic "ssl_protocol_condition" {
      for_each = { for k, v in each.value.conditions : k => v if v.type == "ssl_protocol" }
      content {
        match_values     = ssl_protocol_condition.value.match_values
        operator         = ssl_protocol_condition.value.operator
        negate_condition = ssl_protocol_condition.value.negate_condition
      }
    }
  }
}
