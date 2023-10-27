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
  description = "value of the application name"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group to deploy the dashboard in."
  type        = string
}

variable "location" {
  description = "The Azure Region in which the dashboard should be created."
  type        = string
}

variable "tags" {
  description = "The tags to assign to the resource."
  type        = map(string)
}

variable "template_path" {
  description = "The path to the dashboard template."
  type        = string
}

variable "template_vars" {
  description = "The variables to pass to the dashboard template."
  type        = map(string)
}

variable "project" {
  description = "The project"
  type        = string
}

variable "environment" {
  description = "The environment"
  type        = string
}

variable "padding" {
  description = "The padding"
  type        = string
}
