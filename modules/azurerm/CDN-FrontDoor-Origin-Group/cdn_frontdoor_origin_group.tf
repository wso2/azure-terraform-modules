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

resource "azurerm_cdn_frontdoor_origin_group" "cdn_frontdoor_origin_group" {
  name                     = join("-", [var.origin_group_name, var.origin_group_suffix])
  cdn_frontdoor_profile_id = var.cdn_frontdoor_profile_id
  session_affinity_enabled = var.enable_session_affinity

  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = var.time_to_restore_traffic_to_new_or_healed_endpoints_in_minutes

  dynamic "health_probe" {
    for_each = var.enable_health_probe == true ? ["enable"] : []
    content {
      interval_in_seconds = var.health_probe_check_interval_in_seconds
      path                = var.health_probe_path
      protocol            = var.health_probe_protocol
      request_type        = var.health_probe_request_type
    }
  }

  load_balancing {
    additional_latency_in_milliseconds = var.load_balancing_additional_latency_in_milliseconds
    sample_size                        = var.load_balancing_sample_size
    successful_samples_required        = var.load_balancing_successful_samples_required
  }
}

resource "azurerm_cdn_frontdoor_origin" "cdn_frontdoor_public_origin" {
  for_each                      = var.public_origins
  name                          = each.key
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_group.id
  enabled                       = each.value.enabled

  certificate_name_check_enabled = each.value.check_cert

  host_name          = each.value.host_name
  http_port          = each.value.http_port
  https_port         = each.value.https_port
  origin_host_header = each.value.origin_host_header
  priority           = each.value.priority
  weight             = each.value.weight
}

resource "azurerm_cdn_frontdoor_origin" "cdn_frontdoor_private_link_origin" {
  for_each                      = var.private_link_origins
  name                          = each.key
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_group.id
  enabled                       = each.value.enabled

  certificate_name_check_enabled = true

  host_name          = each.value.host_name
  origin_host_header = each.value.origin_host_header
  priority           = each.value.priority
  weight             = each.value.weight

  private_link {
    target_type            = each.value.private_link_target_type
    location               = each.value.private_link_location
    private_link_target_id = each.value.private_link_target_id
  }
}

resource "azurerm_cdn_frontdoor_origin" "cdn_frontdoor_private_link_service_origin" {
  for_each                      = var.private_link_service_origins
  name                          = each.key
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_group.id
  enabled                       = each.value.enabled

  certificate_name_check_enabled = true

  host_name          = each.value.host_name
  origin_host_header = each.value.origin_host_header
  priority           = each.value.priority
  weight             = each.value.weight

  private_link {
    location               = each.value.private_link_location
    private_link_target_id = each.value.private_link_target_id
  }
}
