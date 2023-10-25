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

variable "padding" {
  type        = string
  description = "Padding to differentiate between resources"
}

variable "vnet_link_name" {
  type        = string
  description = "VNet Link name for the Private DNS Zone"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name of Private DNS Zone"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "project" {
  type        = string
  description = "Project name"
}

variable "application_name" {
  type        = string
  description = "Name of the application"
}

variable "private_dns_zone_name" {
  type        = string
  description = "Existing Private DNS Zone name"
}

variable "virtual_network_id" {
  type        = string
  description = "Existing Virtual Network ID"
}
