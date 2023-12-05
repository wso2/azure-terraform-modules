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

variable "name" {
  description = "The name of the Azure Frontdoor"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the File Share."
  type        = string
}

variable "tags" {
  description = "The tags to associate with the resource"
  type        = map(string)
}

variable "enforce_backend_pools_certificate_name_check" {
  default     = true
  description = "enforce backend pools certificate name check"
  type        = bool
}

variable "load_balancer_enabled" {
  default     = true
  description = "Enable the Front Door Load Balancer"
  type        = bool
}

variable "backend_pools_send_receive_timeout_seconds" {
  default     = 240
  description = "Specifies the send and receive timeout on forwarding request to the backend"
  type        = number
}

variable "routing_rules" {
  default     = []
  description = "Routing rule based on either forwarding or redirect configuration. Note that when creating a routing rule with forwarding configuration, pass the redirect configuration as an empty list (i.e redirect configuration = []) and vice versa"
  type = list(object({
    name               = string
    accepted_protocols = list(string)
    patterns_to_match  = list(string)
    enabled            = bool
    frontend_endpoints = list(string)
    forwarding_configuration = list(object({
      forwarding_protocol                   = string
      backend_pool_name                     = string
      cache_enabled                         = bool
      cache_duration                        = string
      cache_use_dynamic_compression         = bool
      cache_query_parameter_strip_directive = string
      cache_query_parameters                = list(string)
      custom_forwarding_path                = string
    }))
    redirect_configuration = list(object({
      custom_host         = string
      redirect_protocol   = string
      redirect_type       = string
      custom_fragment     = string
      custom_path         = string
      custom_query_string = string
    }))
  }))
}

variable "backend_pool_load_balancing" {
  default     = []
  description = "Backend Pool Load Balancing"
  type = list(object({
    name                            = string
    sample_size                     = number
    successful_samples_required     = number
    additional_latency_milliseconds = number
  }))
}

variable "backend_pool_health_probes" {
  default     = []
  description = "Backend Pool Health Probes"
  type = list(object({
    name                = string
    enabled             = bool
    interval_in_seconds = number
    path                = string
    probe_method        = string
    protocol            = string
  }))
}

variable "backend_pools" {
  default     = []
  description = "Backend pools and Backend"
  type = list(object({
    name                = string
    load_balancing_name = string
    health_probe_name   = string
    backend = list(object({
      enabled     = bool
      address     = string
      host_header = string
      http_port   = number
      https_port  = number
      priority    = number
      weight      = number
    }))
  }))
}

variable "frontend_endpoints" {
  default     = []
  description = "Frontend Endpoints"
  type = list(object({
    name                                    = string
    host_name                               = string
    session_affinity_enabled                = bool
    session_affinity_ttl_seconds            = number
    web_application_firewall_policy_link_id = string
  }))
}
