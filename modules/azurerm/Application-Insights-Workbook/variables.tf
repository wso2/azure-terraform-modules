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
  description = "The project"
  type        = string
}

variable "application_name" {
  description = "The name of the Workbook"
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

variable "template_data_json" {
  description = "Template details"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group to store the workbook"
  type        = string
}

variable "location" {
  description = "Location of the workbook"
  type        = string
}

variable "source_resource_id" {
  default     = "azure monitor"
  description = "An optional resource id to associate the workbook with, defaults to Azure Monitor"
  type        = string
}

variable "category" {
  default     = "workbook"
  description = "Category of the workbook. workbook or sentinel"
  type        = string
}

variable "default_tags" {
  default     = {}
  description = "List of tags to be used with the workbook"
  type        = map(string)

}

variable "description" {
  description = "Description of the Workbook"
  type        = string
}
