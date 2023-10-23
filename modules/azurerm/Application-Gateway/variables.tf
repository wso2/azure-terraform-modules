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

variable "project" {}
variable "environment" {}
variable "location" {}
variable "name" {}
variable "resource_group_name" {}
variable "virtual_network_name" {}
variable "address_prefixes" {
  type = list(string)
}
variable "appgw_private_ip" {}
variable "appgw_zones" {
  description = "Application gateway's Zones to use"
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "service_endpoints" {
  default = ["Microsoft.Sql", "Microsoft.ContainerRegistry", "Microsoft.EventHub", "Microsoft.Storage"]
}

variable "autoscale_configuration_max_capacity" {
  type = number
}

variable "autoscale_configuration_min_capacity" {
  type = number
  default = 1
}

variable "appgw_public_ip_id" {
  type = string
}

variable "frontend_port_settings" {
  description = "Appgw frontent port settings"
  type        = list(map(string))
  default = [{
    fake = "fake"
  }]
}

variable "enable_http2" {
  description = "Enable Http 2"
  default     = true
  type        = bool
}

variable "waf_enabled" {}
variable "waf_file_upload_limit_mb" {
  description = "WAF configuration of the file upload limit in MB"
  type        = number
  default     = 750
}
variable "waf_firewall_mode" {
  description = "Appgw WAF mode"
  type        = string
  default     = "Prevention"
}
variable "waf_max_request_body_size_kb" {
  description = "WAF configuration of the max request body size in KB"
  default     = 128
  type        = number
}
variable "waf_request_body_check" {
  description = "WAF should check the request body"
  default     = true
  type        = bool
}

variable "waf_rule_set_type" {
  description = "WAF rules set type"
  default     = "OWASP"
  type        = string
}

variable "waf_rule_set_version" {
  description = "WAF rules set version"
  default     = "3.1"
  type        = string
}

variable "waf_disabled_rule_group_settings" {
  description = "Appgw WAF rules group to disable."
  type = list(object({
    rule_group_name = string
    rules           = list(string)
  }))
  default = []
}

variable "waf_exclusion_settings" {
  description = "Appgw WAF exclusion settings"
  type        = list(map(string))
  default     = []
}

variable "ssl_policy_name" {
  description = "Name of the SSLPolicy to use with Appgw"
  type        = string
  default     = "AppGwSslPolicy20170401S"
}

variable "appgw_backend_http_settings" {
  type        = any
  description = "List of maps including backend http settings configurations"
  default     = [{ fake = "fake" }]
}

variable "appgw_http_listeners" {
  type        = list(map(string))
  description = "List of maps including http listeners configurations"
  default     = [{ fake = "fake" }]
}

variable "appgw_backend_pools" {
  type        = any
  description = "List of maps including backend pool configurations"
  default     = [{ fake = "fake" }]
}

variable "ssl_certificates_configs" {
  type        = list(map(string))
  description = "List of maps including ssl certificates configurations"
  default     = []
}

variable "authentication_certificate_configs" {
  type        = list(map(string))
  description = "List of maps including authentication certificate configurations"
  default     = []
}

variable "trusted_root_certificate_configs" {
  type        = list(map(string))
  description = "Trusted root certificate configurations"
  default     = []
}

variable "appgw_routings" {
  type        = list(map(string))
  description = "List of maps including request routing rules configurations"
  default     = [{ fake = "fake" }]
}

variable "appgw_rewrite_rule_set" {
  type        = any
  description = "Application gateway's rewrite rules"
  default     = []
}

variable "appgw_probes" {
  type        = any
  description = "List of maps including request probes configurations"
  default = [
    {
      fake = "fake"
  }]
}

variable "appgw_url_path_map" {
  type        = any
  description = "List of maps including url path map configurations"
  default     = []
}

variable "appgw_redirect_configuration" {
  type        = list(map(string))
  description = "List of maps including redirect configurations"
  default     = []
}

variable "network_security_rules" {
  description = "Network Security Rules Map"
  type = map(object({
    name                         = string
    priority                     = number
    direction                    = string
    access                       = string
    protocol                     = string
    source_address_prefix        = string
    source_address_prefixes      = list(string)
    source_port_range            = string
    destination_address_prefix   = string
    destination_address_prefixes = list(string)
    destination_port_range       = string
  }))
}

variable "default_ns_rule_1_priority" {
  type = number
  default = 101
}

variable "default_ns_rule_2_priority" {
  type = number
  default = 102
}

variable "default_tags" {}

variable "padding" {}

variable "application_name" {}
