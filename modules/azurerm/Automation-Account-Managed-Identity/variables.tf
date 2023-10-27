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
  description = "The project name"
  type        = string
}

variable "environment" {
  description = "The enviroment"
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name"
  type        = string
}

variable "location" {
  description = "The cloud region"
  type        = string
}

variable "automation_account_name" {
  description = "The azure automation account name"
  type        = string
}

variable "automation_account_sku_name" {
  default     = "Basic"
  description = "The azure automation account sku name. Default is Basic"
  type        = string
}

variable "tags" {
  description = "The tags"
  type        = map(string)
}
