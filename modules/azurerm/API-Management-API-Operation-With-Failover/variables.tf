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

variable "api_operation_abbreviation" {
  description = "Abbreviation for the API operation"
  type        = string
  default     = "api-op"
}

variable "api_operation_id" {
  description = "A unique identifier for the API operation"
  type        = string
}

variable "api_name" {
  description = "Name of the API where this API Operation should be created"
  type        = string
}

variable "primary_api_management_name" {
  description = "Name of the Primary API Management Service where the API exists"
  type        = string
}

variable "secondary_api_management_name" {
  description = "Name of the Secondary API Management Service where the API exists"
  type        = string
}

variable "resource_group_name" {
  description = "The Name of the Resource Group in which the API Management Service exists."
  type        = string
}

variable "display_name" {
  description = "Display name of the API operation"
  type        = string
}

variable "method" {
  description = "HTTP method used for the API operation"
  type        = string
}

variable "url_template" {
  description = "URL template for the API operation, which may include parameters"
  type        = string
}

variable "template_parameters" {
  description = "Template parameters for the API operation"
  type        = list(object({
    name        = string
    type        = string
    required    = bool
    description = string
  }))
  default     = []
}

variable "policy_xml_template_file_path" {
  description = "The path to the policy XML template file"
  type        = string
}

variable "policy_xml_template_vars" {
  description = "The variables to pass to the policy XML template"
  type        = any
  default     = {}
}
