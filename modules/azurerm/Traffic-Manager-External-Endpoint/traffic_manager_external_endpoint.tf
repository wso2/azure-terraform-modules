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

resource "azurerm_traffic_manager_external_endpoint" "performance_based_external_endpoint" {
  count                = var.routing_method == "Performance" ? 1 : 0
  name                 = var.endpoint_name
  profile_id           = var.profile_id
  target               = var.target
  endpoint_location    = var.endpoint_location
  always_serve_enabled = var.always_serve_enabled
  enabled              = var.enabled
  dynamic "custom_header" {
    for_each = var.custom_headers
    content {
      name  = custom_header.value.header_name
      value = custom_header.value.header_value
    }
  }
}

resource "azurerm_traffic_manager_external_endpoint" "weighted_based_external_endpoint" {
  count                = var.routing_method == "Weighted" ? 1 : 0
  name                 = var.endpoint_name
  profile_id           = var.profile_id
  target               = var.target
  weight               = var.weight
  always_serve_enabled = var.always_serve_enabled
  enabled              = var.enabled
  dynamic "custom_header" {
    for_each = var.custom_headers
    content {
      name  = custom_header.value.header_name
      value = custom_header.value.header_value
    }
  }
}

resource "azurerm_traffic_manager_external_endpoint" "priority_based_external_endpoint" {
  count                = var.routing_method == "Priority" ? 1 : 0
  name                 = var.endpoint_name
  profile_id           = var.profile_id
  target               = var.target
  priority             = var.priority
  always_serve_enabled = var.always_serve_enabled
  enabled              = var.enabled
  dynamic "custom_header" {
    for_each = var.custom_headers
    content {
      name  = custom_header.value.header_name
      value = custom_header.value.header_value
    }
  }
}

resource "azurerm_traffic_manager_external_endpoint" "geographic_based_external_endpoint" {
  count                = var.routing_method == "Geographic" ? 1 : 0
  name                 = var.endpoint_name
  profile_id           = var.profile_id
  target               = var.target
  geo_mappings         = var.geo_mappings
  always_serve_enabled = var.always_serve_enabled
  enabled              = var.enabled
  dynamic "custom_header" {
    for_each = var.custom_headers
    content {
      name  = custom_header.value.header_name
      value = custom_header.value.header_value
    }
  }
}

resource "azurerm_traffic_manager_external_endpoint" "multivalue_based_external_endpoint" {
  count                = var.routing_method == "Multivalue" ? 1 : 0
  name                 = var.endpoint_name
  profile_id           = var.profile_id
  target               = var.target
  always_serve_enabled = var.always_serve_enabled
  enabled              = var.enabled
  dynamic "custom_header" {
    for_each = var.custom_headers
    content {
      name  = custom_header.value.header_name
      value = custom_header.value.header_value
    }
  }
}

resource "azurerm_traffic_manager_external_endpoint" "subnet_based_external_endpoint" {
  count                = var.routing_method == "Subnet" ? 1 : 0
  name                 = var.endpoint_name
  profile_id           = var.profile_id
  target               = var.target
  always_serve_enabled = var.always_serve_enabled
  enabled              = var.enabled
  dynamic "subnet" {
    for_each = var.subnets
    content {
      first = subnet.value.first
      last  = subnet.value.last
      scope = subnet.value.scope
    }
  }
  dynamic "custom_header" {
    for_each = var.custom_headers
    content {
      name  = custom_header.value.header_name
      value = custom_header.value.header_value
    }
  }
}
