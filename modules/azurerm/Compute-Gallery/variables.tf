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

variable "project" {
  type        = string
  description = "The project."
}

variable "environment" {
  type        = string
  description = "The environment."
}

variable "resource_group" {
  type        = string
  description = "The name of the resource group in which to create the Shared Image Gallery."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "description" {
  type        = string
  description = "The description of the resource."
  default     = "The shared custom image compute gallery."
}

variable "resource_group_id" {
  type        = string
  description = "The scope at which the Role Definition applies to."
}

variable "default_tags" {
  description = "The default tags."
  type        = map(string)
}

variable "sig_application_name" {
  type        = string
  description = "The application name of the resource. Changing this forces a new resource to be created"
}

variable "role_definition_description" {
  type        = string
  default     = "Azure Image Builder Service - Image Creation Role"
  description = "A description of the Role Definition"
}

variable "user_assigned_identity_name" {
  type        = string
  description = "The name of the user assigned identity. Changing this forces a new identity to be created"
}

variable "assignable_scopes" {
  type        = list(string)
  default     = []
  description = "One or more assignable scopes for this Role Definition"
}
