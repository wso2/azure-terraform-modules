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
variable "resource_group_name" {}
variable "location" {}
variable "default_tags" {}
variable "virtual_network_name" {}
variable "subnet_address_prefixes" {}
variable "application_name" {}
variable "padding" {}
variable "shortened_project" {}
variable "shortened_environment" {}
variable "shortened_location" {}
variable "shortened_padding" {}
variable "virtual_network_address_space" {}
variable "zones" {}

variable "sku_name" {
  description = "SKU name of the Firewall. Possible values are AZFW_Hub and AZFW_VNet"
  default     = "AZFW_VNet"
  type        = string
}

variable "sku_tier" {
  description = "SKU tier of the Firewall. Possible values are Premium and Standard"
  default     = "Standard"
  type        = string
}

variable "dynamic_nat_rule_collection_priority" {
  description = "Priority of DNat rule collection"
  default     = 100
}

variable "dynamic_nat_rules" {
  description = "Map of nat rules"
  type = map(object({
    public_ip_name         = string
    private_ip_address     = string
    nat_rule_name_shortned = string
    fw_ip_association_name = string
    public_ip_prefix_id    = string
  }))
}

variable "public_ip_prefix_length" {}

variable "network_rule_collection_priority" {
  description = "Priority of Network rule collection"
  default     = 100
}

variable "network_rules" {
  description = "Map of Network rules"
  type = map(object({
    name                  = string
    source_addresses      = list(string)
    destination_ports     = list(string)
    destination_addresses = list(string)
    protocols             = list(string)
  }))
}

variable "application_rule_collection_priority" {
  description = "Priority of Application rule collection"
  default     = 100
}

variable "application_rules" {
  description = "Map of Application rules"
  type = map(object({
    name             = string
    source_addresses = list(string)
    target_fqdns     = list(string)
    protocol = object({
      port = string
      type = string
    })
  }))
}
