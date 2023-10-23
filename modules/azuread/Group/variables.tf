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
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The name of the environment"
  type        = string
}

variable "group_name" {
  description = "The name of the group."
  type        = string
}

variable "group_description" {
  default     = null
  description = "The description for the group."
  type        = string
}
