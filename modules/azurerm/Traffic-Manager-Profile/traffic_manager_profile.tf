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

resource "azurerm_traffic_manager_profile" "traffic_manager_profile" {
  name                   = join("-", ["tm", var.traffic_manager_profile_name])
  resource_group_name    = var.resource_group_name
  traffic_routing_method = var.routing_method
  traffic_view_enabled   = var.traffic_view_enabled
  tags                   = var.tags

  dns_config {
    relative_name = join("-", ["tm", var.traffic_manager_profile_dns_config_relative_name])
    ttl           = var.ttl
  }

  monitor_config {
    protocol                     = var.endpoint_monitoring_protocol
    port                         = var.endpoint_monitoring_protocol == "http" ? 80 : 443
    path                         = var.health_check_path
    interval_in_seconds          = var.health_check_interval
    timeout_in_seconds           = var.health_check_timeout
    tolerated_number_of_failures = var.tolerated_failures
  }
}
