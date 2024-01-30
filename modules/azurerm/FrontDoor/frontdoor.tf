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
  name                  = join("-", ["fd", var.name])
  resource_group_name   = var.resource_group_name
  load_balancer_enabled = var.load_balancer_enabled
  tags                  = var.tags

  dynamic "routing_rule" {
    for_each = toset(var.routing_rules)

    content {
      name               = lookup(routing_rule.value, "name", "default")
      accepted_protocols = lookup(routing_rule.value, "accepted_protocols", ["Http", "Https"])
      patterns_to_match  = lookup(routing_rule.value, "patterns_to_match", ["/*"])
      frontend_endpoints = lookup(routing_rule.value, "frontend_endpoints", ["exampleFrontendEndpoint1"])
      enabled            = lookup(routing_rule.value, "enabled", true)

      dynamic "forwarding_configuration" {
        for_each = toset(routing_rule.value.forwarding_configuration)

        content {
          backend_pool_name                     = lookup(forwarding_configuration.value, "backend_pool_name", "default")
          forwarding_protocol                   = lookup(forwarding_configuration.value, "forwarding_protocol", "HttpsOnly")
          cache_enabled                         = lookup(forwarding_configuration.value, "cache_enabled", false)
          cache_duration                        = lookup(forwarding_configuration.value, "cache_duration", "P0D")
          cache_use_dynamic_compression         = lookup(forwarding_configuration.value, "cache_use_dynamic_compression", false)
          cache_query_parameter_strip_directive = lookup(forwarding_configuration.value, "cache_query_parameter_strip_directive", "StripAll")
          cache_query_parameters                = lookup(forwarding_configuration.value, "cache_query_parameters", "")
          custom_forwarding_path                = lookup(forwarding_configuration.value, "custom_forwarding_path", "")
        }
      }

      dynamic "redirect_configuration" {
        for_each = toset(routing_rule.value.redirect_configuration)

        content {
          redirect_protocol   = redirect_configuration.value.redirect_protocol
          redirect_type       = redirect_configuration.value.redirect_type
          custom_host         = lookup(redirect_configuration.value, "custom_host", "")
          custom_fragment     = lookup(redirect_configuration.value, "custom_fragment", "")
          custom_path         = lookup(redirect_configuration.value, "custom_path", "")
          custom_query_string = lookup(redirect_configuration.value, "custom_query_string", "")
        }
      }
    }
  }

  dynamic "backend_pool_load_balancing" {
    for_each = toset(var.backend_pool_load_balancing)

    content {
      name                            = lookup(backend_pool_load_balancing.value, "name", "default")
      sample_size                     = lookup(backend_pool_load_balancing.value, "sample_size", 4)
      successful_samples_required     = lookup(backend_pool_load_balancing.value, "successful_samples_required", 2)
      additional_latency_milliseconds = lookup(backend_pool_load_balancing.value, "additional_latency_milliseconds", 0)
    }
  }

  dynamic "backend_pool_health_probe" {
    for_each = toset(var.backend_pool_health_probes)

    content {
      name                = lookup(backend_pool_health_probe.value, "name", "default")
      enabled             = lookup(backend_pool_health_probe.value, "enabled", true)
      path                = lookup(backend_pool_health_probe.value, "path", "/")
      protocol            = lookup(backend_pool_health_probe.value, "protocol", "Http")
      probe_method        = lookup(backend_pool_health_probe.value, "probe_method", "GET")
      interval_in_seconds = lookup(backend_pool_health_probe.value, "interval_in_seconds", 120)
    }
  }

  dynamic "backend_pool" {
    for_each = toset(var.backend_pools)

    content {
      name                = lookup(backend_pool.value, "name", "default")
      load_balancing_name = lookup(backend_pool.value, "load_balancing_name", "default")
      health_probe_name   = lookup(backend_pool.value, "health_probe_name", "default")

      dynamic "backend" {
        for_each = toset(backend_pool.value.backend)

        content {
          host_header = lookup(backend.value, "host_header", "${join("-", ["fd", var.name])}.azurefd.net")
          http_port   = lookup(backend.value, "http_port", 80)
          https_port  = lookup(backend.value, "https_port", 443)
          address     = lookup(backend.value, "address", "${join("-", ["fd", var.name])}.azurefd.net")

          enabled  = lookup(backend.value, "enabled", true)
          priority = lookup(backend.value, "priority", 1)
          weight   = lookup(backend.value, "weight", 50)
        }
      }
    }
  }

  dynamic "frontend_endpoint" {
    for_each = toset(var.frontend_endpoints)

    content {
      name                                    = lookup(frontend_endpoint.value, "name", "default")
      host_name                               = lookup(frontend_endpoint.value, "host_name", "${join("-", ["fd", var.name])}.azurefd.net")
      session_affinity_enabled                = lookup(frontend_endpoint.value, "session_affinity_enabled", false)
      session_affinity_ttl_seconds            = lookup(frontend_endpoint.value, "session_affinity_ttl_seconds", 0)
      web_application_firewall_policy_link_id = lookup(frontend_endpoint.value, "web_application_firewall_policy_link_id", "")
    }
  }

  dynamic "backend_pool_setting" {
    for_each = toset(var.backend_pools)

    content {
      backend_pools_send_receive_timeout_seconds   = lookup(backend_pool_setting.value, "enforce_backend_pools_certificate_name_check", false)
      enforce_backend_pools_certificate_name_check = lookup(backend_pool_setting.value, "backend_pools_send_receive_timeout_seconds", 60)
    }
  }
}
