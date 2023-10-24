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

variable "location" {
  description = "The location/region where the resource group will be created."
  type        = string
}

variable "project" {
  description = "value of the project"
  type        = string
}

variable "environment" {
  description = "value of the environment"
  type        = string
}

variable "padding" {
  description = "The padding to be used for indenting the generated HCL code."
  type        = string
}

variable "default_tags" {
  description = "Default tags for the resource group."
  type        = map(string)
}

variable "application_name" {
  description = "The name of the application."
  type        = string
}
