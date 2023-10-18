# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "project_id" {
  description = "Project id"
  type = string
}

variable "project" {
  description = "Project name"
  type = string
}

variable "name" {
  description = "Variable group name"
  type = string
}

variable "description" {
  description = "Variable group description"
  type = string
}

variable "allow_access" {
  description = "Indicate if this variable group is shared by all pipelines of this project"
  type = bool
  default = "false"
}

variable "key_vault_name" {
  description = "Key vault name"
  type = string
}

variable "key_vault_service_endpoint_id" {
  description = "Key vault service connection id"
  type = string
}

variable "key_vault_secrets_name_list" {
  description = "Key vault secrets name list that need to be linked"
  type = list(string)
}
