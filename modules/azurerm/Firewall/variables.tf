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

variable "firewall_name" {
  description = "Name of the Firewall"
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

variable "public_ip_prefixes" {
  description = "Map of public IP prefixes to associate with the Firewall."
  type = map(object({
    public_ip_name         = string
    private_ip_address     = string
    fw_ip_association_name = string
    public_ip_prefix_id    = string
  }))
}

variable "firewall_subnet_enforce_private_link_endpoint_network_policies" {
  default     = false
  description = "Enable or Disable network policies for the private link endpoint on the firewall subnet"
  type        = bool
}
