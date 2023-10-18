# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022 WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "key_vault_id" {
  description = "The ID of the Key Vault where the Secret should be created"
  type        = string
}

variable "secrets_map" {
  description = "Map containing name and value pairs"
  type = map(object({
    name  = string
    value = string
  }))
}
