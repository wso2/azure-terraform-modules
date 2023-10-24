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
  description = "value of the project"
  type        = string
}

variable "environment" {
  description = "value of the environment"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Front Door WAF Object."
  type        = string
}

variable "default_tags" {
  description = "Default tags for the Front Door WAF Object."
  type        = map(string)
}

variable "front_door_waf_object" {
  description = "Front Door WAF Object configuration"
  type        = string
}
