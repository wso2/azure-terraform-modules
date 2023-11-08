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

variable "azurerm_service_endpoint_name" {
  description = "The name of the service endpoint."
  type        = string
}

variable "project_id" {
  description = "The ID of the project."
  type        = string
}

variable "description" {
  description = "The description of the service endpoint."
  type        = string
}

variable "service_principal_id" {
  description = "The service principal application Id."
  type        = string
}

variable "service_principal_key" {
  description = "The service principal secret."
  type        = string
}

variable "tenant_id" {
  description = "The Tenant ID if the service principal."
  type        = string
}

variable "subscription_id" {
  description = "The Subscription ID of the Azure targets."
  type        = string
}

variable "subscription_name" {
  description = "The Subscription Name of the targets."
  type        = string
}
