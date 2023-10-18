# -------------------------------------------------------------------------------------
#
# Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "scope_id" {
    description = "Scope at which the management lock should be created"
}

variable "name" {
    default     = "azure_resource_lock"
    description = "Specifies the name of the management lock"
}

variable "level" {
    default     = "CanNotDelete"
    description = "Specifies the the level to be used for this Lock"
}

variable "notes" {
    default     = "Resource locked to prevent accidental deletions"
    description = "Specifies some notes about the lock."
}
