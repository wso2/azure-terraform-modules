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
  description = "The ID of the project."
  type        = string
}

variable "resource_id" {
  description = "The ID of the resource."
  type        = string
}

variable "definition_id" {
  description = "The ID of the definition."
  type        = string
}

variable "authorized" {
  default     = "true"
  description = "Whether the resource is authorized."
  type        = bool
}

variable "authorized_type" {
  description = "The type of the resource to authorize. Type: string. Valid values: endpoint, queue, variablegroup"
  type        = string
}
