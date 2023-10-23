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

variable "role_definition_name" {
  type        = string
  description = "The name of the Role Definition."
}

variable "role_definition_scope" {
  type        = string
  description = "The scope at which the Role Definition applies to."
}

variable "description" {
  type        = string
  description = "A description of the Role Definition."
}

variable "allowed_actions_list" {
  type        = list(string)
  description = "List of one or more allowed Actions."
}

variable "disallowed_actions_list" {
  type        = list(string)
  description = "List of one or more disallowed Actions."
  default     = []
}

variable "allowed_data_actions_list" {
  type        = list(string)
  description = "List of one or more allowed Data Actions."
  default     = []
}

variable "disallowed_data_actions_list" {
  type        = list(string)
  description = "List of one or more disallowed Data Actions."
  default     = []
}

variable "assignable_scopes" {
  description = "List of assignable scopes"
  default     = []
  type        = list(string)
}
