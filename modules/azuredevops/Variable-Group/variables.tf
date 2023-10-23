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

variable "project_id" {
  description = "Project id"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "name" {
  description = "Variable group name"
  type        = string
}

variable "description" {
  description = "Variable group description"
  type        = string
}

variable "allow_access" {
  default     = "false"
  description = "Indicate if this variable group is shared by all pipelines of this project"
  type        = bool
}

variable "variables_map" {
  description = "Variables map that need to be added to the variable group"
  type        = list(map(string))
}

variable "secrets_map" {
  description = "Secrets map that need to be added to the variable group"
  type        = list(map(string))
}

variable "is_secret" {
  default     = "true"
  description = "Indicate if the variable is a secret"
  type        = bool
}
