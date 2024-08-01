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

variable "api_abbreviation" {
  description = "Abbreviation for the API Name"
  type        = string
  default     = "api"
}

variable "api_name" {
  description = "Name of the API"
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
  description = "The name of the resource group in which to create the API Management API"
  type        = string
}

variable "api_revision" {
  description = "Revision number for the API"
  type        = string
  default     = "1"
}

variable "api_type" {
  description = "Type of the API. Possible values are graphql, http, soap, and websocket"
  type        = string
  default     = "http"
}

variable "display_name" {
  description = "Display name of the API"
  type        = string
}

variable "path" {
  description = "The Path for this API Management API, which is a relative URL which uniquely identifies this API and all of its resource paths within the API Management Service"
  type        = string
  default     = ""
}

variable "protocols" {
  description = "A list of protocols the operations in this API can be invoked. Possible values are http, https, ws, and wss"
  type        = list(string)
  default     = ["https"]
}

variable "backend_service_url" {
  description = "Absolute URL of the backend service which utilizes this API"
  type        = string
}

variable "subscription_required" {
  description = "Whether a subscription is required for the API"
  type        = bool
  default     = false
}

variable "xml_template_file_path" {
  description = "The path to the policy XML template file"
  type        = string
}

variable "xml_template_vars" {
  description = "The variables to pass to the policy XML template"
  type        = any
}
