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
  type        = string
  description = "The project"
}
variable "application_name" {
  type        = string
  description = "The name of the Workbook"
}
variable "environment" {
  type        = string
  description = "The environment"
}
variable "padding" {
  type        = string
  description = "The padding"
}
variable "template_data_json" {
  type        = string
  description = "Template details"
}
variable "resource_group_name" {
  type        = string
  description = "Resource group to store the workbook"
}
variable "location" {
  type        = string
  description = "Location of the workbook"
}
variable "source_resource_id" {
  type        = string
  description = "An optional resource id to associate the workbook with, defaults to Azure Monitor"
  default     = "azure monitor"
}
variable "category" {
  type        = string
  description = "Category of the workbook. workbook or sentinel"
  default     = "workbook"
}
variable "default_tags" {
  type        = map(string)
  description = "List of tags to be used with the workbook"
  default     = {}
}
variable "description" {
  type        = string
  description = "Description of the Workbook"
}
