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

variable "entra_app_display_name" {
  description = "The display name of the Azure AD application."
  type        = string
}

variable "description" {
  description = "The description of the Azure AD application."
  type        = string
}

variable "owners" {
  type        = set(string)
  description = "A set of object ids of the owners of the Azure AD application."
}

variable "role_assignments" {
  description = "A map of role assignments with scope and role definition name."
  type = map(object({
    scope                = string
    role_definition_name = string
  }))
  default = null
}

variable "required_resource_access_map" {
  description = "A map of resource_app_id to a map of resource_access objects."
  type        = map(map(string))
  default     = null
}

variable "custom_role_definitions" {
  description = "Map of custom role definitions"
  type = map(object({
    name        = string
    description = string
    permissions = list(string)
    scope       = string
  }))
  default = {}
}
