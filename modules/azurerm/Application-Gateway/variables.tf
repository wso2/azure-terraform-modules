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

variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "name" {
  description = "Name of the resource"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "address_prefixes" {
  description = "Address prefixes of the virtual network"
  type        = list(string)
}

variable "appgw_private_ip" {
  description = "Application gateway's private IP address"
  type        = string
}

variable "appgw_zones" {
  default     = ["1", "2", "3"]
  description = "Application gateway's Zones to use"
  type        = list(string)
}

variable "service_endpoints" {
  default     = ["Microsoft.Sql", "Microsoft.ContainerRegistry", "Microsoft.EventHub", "Microsoft.Storage"]
  description = "Service endpoints to enable"
  type        = list(string)
}

variable "autoscale_configuration_max_capacity" {
  description = "Maximum number of instances in the autoscale configuration"
  type        = number
}

variable "autoscale_configuration_min_capacity" {
  default     = 1
  description = "Minimum number of instances in the autoscale configuration"
  type        = number
}

variable "appgw_public_ip_id" {
  description = "Application gateway's public IP address ID"
  type        = string
}

variable "frontend_port_settings" {
  default = [{
    fake = "fake"
  }]
  description = "Appgw frontent port settings"
  type        = list(map(string))
}

variable "enable_http2" {
  default     = true
  description = "Enable Http 2"
  type        = bool
}

variable "waf_enabled" {
  description = "Appgw WAF enabled"
  type        = bool
}

variable "waf_file_upload_limit_mb" {
  default     = 750
  description = "WAF configuration of the file upload limit in MB"
  type        = number
}

variable "waf_firewall_mode" {
  default     = "Prevention"
  description = "Appgw WAF mode. Valid values are Detection, Prevention."
  type        = string
}

variable "waf_max_request_body_size_kb" {
  default     = 128
  description = "WAF configuration of the max request body size in KB"
  type        = number
}

variable "waf_request_body_check" {
  default     = true
  description = "WAF should check the request body"
  type        = bool
}

variable "waf_rule_set_type" {
  default     = "OWASP"
  description = "WAF rules set type. Valid values are OWASP, CRS."
  type        = string
}

variable "waf_rule_set_version" {
  default     = "3.1"
  description = "WAF rules set version"
  type        = string
}

variable "waf_disabled_rule_group_settings" {
  default     = []
  description = "Appgw WAF rules group to disable."
  type = list(object({
    rule_group_name = string
    rules           = list(string)
  }))
}

variable "waf_exclusion_settings" {
  default     = []
  description = "Appgw WAF exclusion settings"
  type        = list(map(string))
}

variable "ssl_policy_name" {
  default     = "AppGwSslPolicy20170401S"
  description = "Name of the SSLPolicy to use with Appgw"
  type        = string
}

variable "appgw_backend_http_settings" {
  default     = [{ fake = "fake" }]
  description = "List of maps including backend http settings configurations"
  type        = list(map(string))
}

variable "appgw_http_listeners" {
  default     = [{ fake = "fake" }]
  description = "List of maps including http listeners configurations"
  type        = list(map(string))
}

variable "appgw_backend_pools" {
  default     = [{ fake = "fake" }]
  description = "List of maps including backend pool configurations"
  type        = list(map(string))
}

variable "ssl_certificates_configs" {
  default     = []
  description = "List of maps including ssl certificates configurations"
  type        = list(map(string))
}

variable "authentication_certificate_configs" {
  default     = []
  description = "List of maps including authentication certificate configurations"
  type        = list(map(string))
}

variable "trusted_root_certificate_configs" {
  default     = []
  description = "Trusted root certificate configurations"
  type        = list(map(string))
}

variable "appgw_routings" {
  default     = [{ fake = "fake" }]
  description = "List of maps including request routing rules configurations"
  type        = list(map(string))
}

variable "appgw_rewrite_rule_set" {
  default     = []
  description = "Application gateway's rewrite rules"
  type        = list(map(string))
}

variable "appgw_probes" {
  default = [
    {
      fake = "fake"
  }]
  description = "List of maps including request probes configurations"
  type        = list(map(string))
}

variable "appgw_url_path_map" {
  default     = []
  description = "List of maps including url path map configurations"
  type        = list(map(string))
}

variable "appgw_redirect_configuration" {
  default     = []
  description = "List of maps including redirect configurations"
  type        = list(map(string))
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
  default     = 101
  description = "Default network security rule 1 priority"
  type        = number
}

variable "default_ns_rule_2_priority" {
  default     = 102
  description = "value of the default network security rule 2 priority"
  type        = number
}

variable "tags" {
  default     = {}
  description = "Tags to be used in the resource tags"
  type        = map(string)
}

variable "padding" {
  description = "Padding to differentiate between resources"
  type        = string
}

variable "application_name" {
  description = "Application name"
  type        = string
}
