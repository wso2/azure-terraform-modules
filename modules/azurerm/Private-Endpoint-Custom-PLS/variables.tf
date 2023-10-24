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
  description = "Private Endpoint subnet ID"
  type        = string
}
variable "location" {
  description = "Location of the deployment"
  type        = string
}
variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}
variable "private_link_service_connection_name" {
  description = "Private Link Service Connection name"
  type        = string
}
variable "private_link_resource_alias" {
  description = "Private Link Service Resources alias"
  type        = string
}
variable "tags" {
  type        = map(string)
  description = "The default tags."
}
variable "project" {
  description = "The name of the project"
  type        = string
}
variable "connection_request_message" {
  description = "The connection request message to the PLS"
  type        = string
}
variable "workload_name" {
  description = "The workload name of the PLE"
  type        = string
}
variable "environment" {
  description = "The enviroment of the deployment"
  type        = string
}
variable "padding" {
  description = "Padding for the deployment"
  type        = string
}
