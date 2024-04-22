# -------------------------------------------------------------------------------------
#
# Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "resource_group_name" {
  description = "The name of the resource group where the resource needs to be created."
  type        = string
}

variable "location" {
  description = "The location of the resource where the resource needs to be created."
  type        = string
}

variable "lb_name" {
  description = "The name of the load balancer."
  type        = string
}

variable "tags" {
  description = "The mapping of resource tags"
  type        = map(string)
}

variable "sku" {
  description = "The SKU of the Azure Load Balancer. Accepted values are Basic, Standard and Gateway"
  type        = string
  default     = "Standard"
}

variable "sku_tier" {
  description = "The SKU tier of this Load Balancer. Possible values are Global and Regional"
  type        = string
  default     = "Regional"
}

variable "frontend_ip_configuration" {
  default     = []
  description = "Frontend IP configuration for the Azure LB"
  type = list(object({
    name                          = string,
    private_ip_address_allocation = string,
    subnet_id                     = string,
    private_ip_address            = string
  }))
}

variable "lb_abbreviation" {
  description = "The abbreviation of the resource name."
  type        = string
  default     = "lb"
}
