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
  description = "The name of the Role Definition."
  type        = string
}

variable "role_definition_scope" {
  description = "The scope at which the Role Definition applies to."
  type        = string
}

variable "description" {
  description = "A description of the Role Definition."
  type        = string
}

variable "allowed_actions_list" {
  description = "List of one or more allowed Actions."
  type        = list(string)
}

variable "disallowed_actions_list" {
  default     = []
  description = "List of one or more disallowed Actions."
  type        = list(string)
}

variable "allowed_data_actions_list" {
  default     = []
  description = "List of one or more allowed Data Actions."
  type        = list(string)
}

variable "disallowed_data_actions_list" {
  default     = []
  description = "List of one or more disallowed Data Actions."
  type        = list(string)
}

variable "assignable_scopes" {
  default     = []
  description = "List of assignable scopes"
  type        = list(string)
}
