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
variable "private_endpoint_subnet_id" {
  description = "The ID of the subnet to associate with the private endpoint."
  type        = string
}

variable "location" {
  description = "The Azure Region in which the private endpoint should be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the private endpoint."
  type        = string
}

variable "private_connection_resource_id" {
  description = "The ID of the resource to connect to the private endpoint."
  type        = string
}

variable "private_dns_zone_ids" {
  description = "The IDs of the private DNS zones to link to the private endpoint."
  type        = list(string)
}

variable "subresource_names" {
  description = "The names of the subresources to link to the private endpoint."
  type        = list(string)
}

variable "tags" {
  description = "Tags for the private endpoint."
  type        = map(string)
}

variable "project" {
  description = "value of the project"
  type        = string
}

variable "workload_name" {
  description = "value of the workload name"
  type        = string
}

variable "environment" {
  description = "value of the environment"
  type        = string
}

variable "padding" {
  description = "Padding to differentiate between resources"
  type        = string
}
