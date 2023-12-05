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

variable "name" {
  description = "The name of the Container Registry."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Container Registry."
  type        = string
}

variable "location" {
  description = "The Azure location in which to create the Container Registry."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}

variable "georeplication_locations" {
  default     = []
  description = "A list of Azure locations where the Container Registry should be geo-replicated."
  type = list(object({
    location    = string
    zrs_enabled = bool
  }))
}

variable "public_network_access_enabled" {
  default     = false
  description = "Should public network access be allowed for the Container Registry?"
  type        = bool
}

variable "network_rule_set_default_action" {
  default     = "Allow"
  description = "The default action of the network rule set."
  type        = string
}

variable "network_rules" {
  default     = null
  description = "A set of network rules associated with the Container Registry."
  type = object({
    ip_rules = list(string)
  })
}
