# -------------------------------------------------------------------------------------
#
# Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "container_registry_name" {
  description = "The name of the Azure Container Registry Token."
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group in which the Azure Container Registry Token is created."
  type        = string
}
variable "actions" {
  description = "The actions that the Azure Container Registry Token can perform."
  type        = list(string)
  default     = []
}
variable "scope_map_name" {
  description = "The name of the scope map for the Azure Container Registry Token."
  type        = string
}
