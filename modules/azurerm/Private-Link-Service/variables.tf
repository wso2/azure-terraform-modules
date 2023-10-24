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
variable "application_name" {
  description = "The name of the application."
  type        = string
}
variable "project" {
  description = "The name of the project. Eg: asgardeo"
  type        = string
}
variable "environment" {
  description = "The name of the environment. Eg: dev"
  type        = string
}
variable "location" {
  description = "The location of the resource need to be created."
  type        = string
}
variable "padding" {
  description = "The padding value."
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group in which the subnet is created in."
  type        = string
}
variable "default_tags" {
  default     = {}
  description = "The default tags."
  type        = map(string)
}
variable "visible_consumer_subscription_ids" {
  default     = []
  description = "List of Subscription IDs which can view this Private Link Service"
  type        = list(string)
}
variable "auto_approved_consumer_subscription_ids" {
  default     = []
  description = "List of Subscription IDs whose Private Endpoint to the PLS would be auto approved"
  type        = list(string)
}
variable "frontend_ip_config_ids" {
  default     = []
  description = "List of Frontend IPs connected to the Private Link Service"
  type        = list(string)
}
variable "nat_ip_configurations" {
  default     = []
  description = "List of NAT IP configurations used for the Private Link Service"
  type = list(object({
    name               = string
    primary            = bool
    subnet_id          = string
    private_ip_address = string
  }))
}
