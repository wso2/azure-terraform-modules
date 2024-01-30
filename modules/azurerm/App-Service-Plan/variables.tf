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

variable "app_service_plan_name" {
  description = "App service plan name"
  type        = string
}

variable "location" {
  description = "Location identifier"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "tier" {
  description = "Tier of the resource"
  type        = string
}

variable "size" {
  description = "Size of the resource"
  type        = string
}

variable "capacity" {
  description = "Capacity of the resource"
  type        = number
}

variable "app_service_plan_kind" {
  default     = "Linux"
  description = "Kind of the app service plan"
  type        = string
}

variable "tags" {
  default     = {}
  description = "Tags to be used in the resource tags"
  type        = map(string)
}

variable "per_site_scaling" {
  default     = false
  description = "Per site scaling of the app service plan"
  type        = bool
}

variable "zrs_enabled" {
  default     = false
  description = "ZRS enabled of the app service plan"
  type        = bool
}

variable "reserved" {
  default     = true
  description = "Whether the app service plan is reserved or not"
  type        = bool
}
