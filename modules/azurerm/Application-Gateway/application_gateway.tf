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

resource "azurerm_application_gateway" "app_gateway" {
  depends_on = [
    azurerm_network_security_group.network_security_group,
    azurerm_network_security_rule.default_network_security_rule,
    azurerm_network_security_rule.default_network_security_rule_2,
  ]
  location            = var.location
  name                = local.appgw_name
  resource_group_name = var.resource_group_name

  sku {
    name = "WAF_v2"
    tier = "WAF_v2"
  }

  autoscale_configuration {
    min_capacity = var.autoscale_configuration_min_capacity
    max_capacity = var.autoscale_configuration_max_capacity
  }

  zones = var.appgw_zones

  frontend_ip_configuration {
    name                 = local.frontend_public_ip_configuration_name
    public_ip_address_id = var.appgw_public_ip_id
  }

  frontend_ip_configuration {
    name                          = local.frontend_private_ip_configuration_name
    private_ip_address_allocation = "Static"
    private_ip_address            = var.appgw_private_ip
    subnet_id                     = azurerm_subnet.app_gateway_subnet.id
  }

  dynamic "frontend_port" {
    for_each = var.frontend_port_settings
    content {
      name = lookup(frontend_port.value, "name", "dummy")
      port = lookup(frontend_port.value, "port", 80)
    }
  }

  gateway_ip_configuration {
    name      = local.gateway_ip_configuration_name
    subnet_id = azurerm_subnet.app_gateway_subnet.id
  }

  waf_configuration {
    enabled                  = var.waf_enabled
    file_upload_limit_mb     = var.waf_file_upload_limit_mb
    firewall_mode            = var.waf_firewall_mode
    max_request_body_size_kb = var.waf_max_request_body_size_kb
    request_body_check       = var.waf_request_body_check
    rule_set_type            = var.waf_rule_set_type
    rule_set_version         = var.waf_rule_set_version

    dynamic "disabled_rule_group" {
      for_each = var.waf_disabled_rule_group_settings
      content {
        rule_group_name = lookup(disabled_rule_group.value, "rule_group_name")
        rules           = lookup(disabled_rule_group.value, "rules")
      }
    }

    dynamic "exclusion" {
      for_each = var.waf_exclusion_settings
      content {
        match_variable          = lookup(exclusion.value, "match_variable")
        selector                = lookup(exclusion.value, "selector")
        selector_match_operator = lookup(exclusion.value, "selector_match_operator")
      }
    }
  }

  ssl_policy {
    policy_type = "Predefined"
    policy_name = var.ssl_policy_name
  }

  enable_http2 = var.enable_http2

  #
  # Backend HTTP settings
  #

  dynamic "backend_http_settings" {
    for_each = var.appgw_backend_http_settings
    content {
      name       = lookup(backend_http_settings.value, "name", "dummy")
      path       = lookup(backend_http_settings.value, "path", "/")
      probe_name = lookup(backend_http_settings.value, "probe_name", "dummy")

      affinity_cookie_name                = "ApplicationGatewayAffinity"
      cookie_based_affinity               = lookup(backend_http_settings.value, "cookie_based_affinity", "Disabled")
      pick_host_name_from_backend_address = lookup(backend_http_settings.value, "pick_host_name_from_backend_address", false)
      host_name                           = lookup(backend_http_settings.value, "host_name", "dummy")
      port                                = lookup(backend_http_settings.value, "port", 80)
      protocol                            = lookup(backend_http_settings.value, "protocol", "Http")
      request_timeout                     = lookup(backend_http_settings.value, "request_timeout", 1)
      trusted_root_certificate_names      = lookup(backend_http_settings.value, "trusted_root_certificate_names", [])
    }
  }

  #
  # HTTP listener
  #

  dynamic "http_listener" {
    for_each = var.appgw_http_listeners
    content {
      name                           = lookup(http_listener.value, "name", "dummy")
      frontend_ip_configuration_name = lookup(http_listener.value, "frontend_ip_configuration_name", local.frontend_private_ip_configuration_name)
      frontend_port_name             = lookup(http_listener.value, "frontend_port_name", "dummy")
      protocol                       = lookup(http_listener.value, "protocol", "Http")
      ssl_certificate_name           = lookup(http_listener.value, "ssl_certificate_name", null)
      host_name                      = lookup(http_listener.value, "host_name", "dummy")
      require_sni                    = lookup(http_listener.value, "require_sni", null)
    }
  }

  #
  # Backend address pool
  #

  dynamic "backend_address_pool" {
    for_each = var.appgw_backend_pools
    content {
      name  = lookup(backend_address_pool.value, "name", "dummy")
      fqdns = lookup(backend_address_pool.value, "fqdns", ["dummy"])
    }
  }

  #
  # SSL certificate
  #

  dynamic "ssl_certificate" {
    for_each = var.ssl_certificates_configs
    content {
      name     = lookup(ssl_certificate.value, "name")
      data     = filebase64(lookup(ssl_certificate.value, "data"))
      password = lookup(ssl_certificate.value, "password")
    }
  }

  #
  # Authentication certificate
  #

  dynamic "authentication_certificate" {
    for_each = var.authentication_certificate_configs
    content {
      name = lookup(authentication_certificate.value, "name")
      data = filebase64(lookup(authentication_certificate.value, "data"))
    }
  }

  #
  # Trusted root certificate
  #

  dynamic "trusted_root_certificate" {
    for_each = var.trusted_root_certificate_configs
    content {
      name = lookup(trusted_root_certificate.value, "name")
      data = filebase64(lookup(trusted_root_certificate.value, "data"))
    }
  }

  #
  # Request routing rule
  #

  dynamic "request_routing_rule" {
    for_each = var.appgw_routings
    content {
      name      = lookup(request_routing_rule.value, "name", "dummy")
      rule_type = lookup(request_routing_rule.value, "rule_type", "Basic")

      http_listener_name          = lookup(request_routing_rule.value, "http_listener_name", lookup(request_routing_rule.value, "name", "dummy"))
      backend_address_pool_name   = lookup(request_routing_rule.value, "backend_address_pool_name", lookup(request_routing_rule.value, "name", "dummy"))
      backend_http_settings_name  = lookup(request_routing_rule.value, "backend_http_settings_name", lookup(request_routing_rule.value, "name", "dummy"))
      url_path_map_name           = lookup(request_routing_rule.value, "url_path_map_name", null)
      redirect_configuration_name = lookup(request_routing_rule.value, "redirect_configuration_name", null)
      rewrite_rule_set_name       = lookup(request_routing_rule.value, "rewrite_rule_set_name", null)
      priority                    = lookup(request_routing_rule.value, "priority", 1000)
    }
  }

  #
  # Rewrite rule set
  #

  dynamic "rewrite_rule_set" {
    for_each = var.appgw_rewrite_rule_set
    content {
      name = lookup(rewrite_rule_set.value, "name", null)
      dynamic "rewrite_rule" {
        for_each = lookup(rewrite_rule_set.value, "rewrite_rule")
        content {
          name          = lookup(rewrite_rule.value, "name")
          rule_sequence = lookup(rewrite_rule.value, "rule_sequence")

          condition {
            ignore_case = lookup(rewrite_rule.value, "condition_ignore_case", null)
            negate      = lookup(rewrite_rule.value, "condition_negate", null)
            pattern     = lookup(rewrite_rule.value, "condition_pattern", null)
            variable    = lookup(rewrite_rule.value, "condition_variable", null)
          }

          response_header_configuration {
            header_name  = lookup(rewrite_rule.value, "response_header_name", null)
            header_value = lookup(rewrite_rule.value, "response_header_value", null)
          }
        }
      }
    }
  }

  #
  # Probe
  #

  dynamic "probe" {
    for_each = var.appgw_probes
    content {
      host                = lookup(probe.value, "host", "dummy")
      interval            = lookup(probe.value, "interval", 30)
      name                = lookup(probe.value, "name", "dummy")
      path                = lookup(probe.value, "path", "/")
      protocol            = lookup(probe.value, "protocol", "Http")
      timeout             = lookup(probe.value, "timeout", 30)
      unhealthy_threshold = lookup(probe.value, "unhealthy_threshold", 3)
      match {
        body        = lookup(probe.value, "match_body", "")
        status_code = lookup(probe.value, "match_status_code", ["200"])
      }
    }
  }

  #
  # URL path map
  #

  dynamic "url_path_map" {
    for_each = var.appgw_url_path_map
    content {
      name                               = lookup(url_path_map.value, "name")
      default_backend_address_pool_name  = lookup(url_path_map.value, "default_backend_address_pool_name")
      default_backend_http_settings_name = lookup(url_path_map.value, "default_backend_http_settings_name", lookup(url_path_map.value, "default_backend_address_pool_name"))

      dynamic "path_rule" {
        for_each = lookup(url_path_map.value, "path_rule")
        content {
          name                       = lookup(path_rule.value, "path_rule_name")
          backend_address_pool_name  = lookup(path_rule.value, "backend_address_pool_name", lookup(path_rule.value, "path_rule_name"))
          backend_http_settings_name = lookup(path_rule.value, "backend_http_settings_name", lookup(path_rule.value, "path_rule_name"))
          paths                      = [lookup(path_rule.value, "paths")]
        }
      }
    }
  }

  #
  # Redirect configuration
  #

  dynamic "redirect_configuration" {
    for_each = var.appgw_redirect_configuration
    content {
      name                 = lookup(redirect_configuration.value, "name")
      redirect_type        = lookup(redirect_configuration.value, "redirect_type", "Permanent")
      target_listener_name = lookup(redirect_configuration.value, "target_listener_name")
      include_path         = lookup(redirect_configuration.value, "include_path", "true")
      include_query_string = lookup(redirect_configuration.value, "include_query_string", "true")
    }
  }

  tags = local.appgw_tags

  // Ignore most changes as they should be managed by AKS ingress controller
  lifecycle {
    ignore_changes = [
      backend_address_pool,
      backend_http_settings,
      frontend_port,
      http_listener,
      probe,
      request_routing_rule,
      url_path_map,
      ssl_certificate,
      redirect_configuration,
      tags,
      trusted_root_certificate
    ]
  }

}
