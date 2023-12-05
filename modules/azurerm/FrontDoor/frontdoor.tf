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

#Create Azure Front Door Resource
resource "azurerm_frontdoor" "frontdoor" {
  name                                         = join("-", ["fd", var.name])
  resource_group_name                          = var.resource_group_name
  load_balancer_enabled                        = var.load_balancer_enabled
  enforce_backend_pools_certificate_name_check = var.enforce_backend_pools_certificate_name_check
  backend_pools_send_receive_timeout_seconds   = var.backend_pools_send_receive_timeout_seconds
  tags                                         = var.tags

  dynamic "routing_rule" {
    for_each = toset(var.routing_rules)

    content {
      name               = routing_rule.value.name
      accepted_protocols = routing_rule.value.accepted_protocols
      patterns_to_match  = routing_rule.value.patterns_to_match
      enabled            = routing_rule.value.enabled
      frontend_endpoints = routing_rule.value.frontend_endpoints

      dynamic "forwarding_configuration" {
        for_each = toset(routing_rule.value.forwarding_configuration)

        content {
          forwarding_protocol                   = forwarding_configuration.value.forwarding_protocol
          backend_pool_name                     = forwarding_configuration.value.backend_pool_name
          cache_enabled                         = forwarding_configuration.value.cache_enabled
          cache_duration                        = forwarding_configuration.value.cache_duration
          cache_use_dynamic_compression         = forwarding_configuration.value.cache_use_dynamic_compression
          cache_query_parameter_strip_directive = forwarding_configuration.value.cache_query_parameter_strip_directive
          cache_query_parameters                = forwarding_configuration.value.cache_query_parameters
          custom_forwarding_path                = forwarding_configuration.value.custom_forwarding_path
        }
      }

      dynamic "redirect_configuration" {
        for_each = toset(routing_rule.value.redirect_configuration)

        content {
          custom_host         = redirect_configuration.value.custom_host
          redirect_protocol   = redirect_configuration.value.redirect_protocol
          redirect_type       = redirect_configuration.value.redirect_type
          custom_fragment     = redirect_configuration.value.custom_fragment
          custom_path         = redirect_configuration.value.custom_path
          custom_query_string = redirect_configuration.value.custom_query_string
        }
      }
    }
  }

  dynamic "backend_pool_load_balancing" {
    for_each = toset(var.backend_pool_load_balancing)

    content {
      name                            = backend_pool_load_balancing.value.name
      sample_size                     = backend_pool_load_balancing.value.sample_size
      successful_samples_required     = backend_pool_load_balancing.value.successful_samples_required
      additional_latency_milliseconds = backend_pool_load_balancing.value.additional_latency_milliseconds
    }

  }

  dynamic "backend_pool_health_probe" {
    for_each = toset(var.backend_pool_health_probes)

    content {
      name                = backend_pool_health_probe.value.name
      enabled             = backend_pool_health_probe.value.enabled
      path                = backend_pool_health_probe.value.path
      protocol            = backend_pool_health_probe.value.protocol
      probe_method        = backend_pool_health_probe.value.probe_method
      interval_in_seconds = backend_pool_health_probe.value.interval_in_seconds
    }
  }

  dynamic "backend_pool" {
    for_each = toset(var.backend_pools)

    content {
      name                = backend_pool.value.name
      load_balancing_name = backend_pool.value.load_balancing_name
      health_probe_name   = backend_pool.value.health_probe_name

      dynamic "backend" {
        for_each = toset(backend_pool.value.backend)

        content {
          enabled     = backend.value.enabled
          address     = backend.value.address
          host_header = backend.value.host_header
          http_port   = backend.value.http_port
          https_port  = backend.value.https_port
          priority    = backend.value.priority
          weight      = backend.value.weight
        }
      }
    }
  }

  dynamic "frontend_endpoint" {
    for_each = toset(var.frontend_endpoints)

    content {
      name                                    = frontend_endpoint.value.name
      host_name                               = frontend_endpoint.value.host_name
      web_application_firewall_policy_link_id = frontend_endpoint.value.web_application_firewall_policy_link_id
    }
  }
}
