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

variable "scope_id" {
  description = "Scope at which the management lock should be created"
  type        = string
}

variable "name" {
  default     = "azure_resource_lock"
  description = "Specifies the name of the management lock"
  type        = string
}

variable "level" {
  default     = "CanNotDelete"
  description = "Specifies the the level to be used for this Lock"
  type        = string
}

variable "notes" {
  default     = "Resource locked to prevent accidental deletions"
  description = "Specifies some notes about the lock."
  type        = string
}
