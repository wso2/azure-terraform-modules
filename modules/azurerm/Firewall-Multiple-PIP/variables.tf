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

variable "firewall_application_rule_collection_name" {
  description = "Name of the Firewall Application Rule Collection"
  type        = string
}

variable "firewall_name" {
  description = "Name of the Firewall"
  type        = string
}

variable "firewall_nat_rule_collection_name" {
  description = "Name of the Firewall NAT Rule Collection"
  type        = string
}

variable "firewall_network_rule_collection_name" {
  description = "Name of the Firewall Network Rule Collection"
  type        = string
}

variable "firewall_public_ip_prefix_name" {
  description = "Name of the Firewall Public IP Prefix"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure Region."
  type        = string
}

variable "tags" {
  description = "Tags for the Firewall."
  type        = map(string)
}

variable "virtual_network_name" {
  description = "The name of the Virtual Network in which to create the Firewall."
  type        = string
}

variable "subnet_address_prefixes" {
  description = "The address prefixes to use for the subnet."
  type        = string
}

variable "zones" {
  description = "The Availability Zones in which to create the Firewall."
  type        = list(string)
}

variable "sku_name" {
  default     = "AZFW_VNet"
  description = "SKU name of the Firewall. Possible values are AZFW_Hub and AZFW_VNet"
  type        = string
}

variable "sku_tier" {
  default     = "Standard"
  description = "SKU tier of the Firewall. Possible values are Premium and Standard"
  type        = string
}

variable "dynamic_nat_rule_collection_priority" {
  default     = 100
  description = "Priority of DNat rule collection"
  type        = number
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

variable "public_ip_prefix_length" {
  description = "Length of the public ip prefix"
  type        = number
}

variable "network_rule_collection_priority" {
  default     = 100
  description = "Priority of Network rule collection"
  type        = number
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
  default     = 100
  description = "Priority of Application rule collection"
  type        = number
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

variable "private_endpoint_network_policies" {
  default     = "Disabled"
  description = "Enable or Disable network policies for the private endpoint on the subnet. Possible values are Disabled, Enabled, NetworkSecurityGroupEnabled and RouteTableEnabled"
  type        = string
}

variable "public_ip_zones" {
  default     = [1, 2, 3]
  description = "A collection containing the availability zone to allocate the Public IP in"
  type        = list(number)
}
