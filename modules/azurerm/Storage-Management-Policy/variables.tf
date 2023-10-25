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

variable "storage_account_id" {
  description = "Specifies the id of the storage account to apply the management policy to"
  type        = string
}

variable "rules" {
  description = "Specifies the rules for the management policy"
  type = map(
    object({
      enabled      = bool,
      prefix_match = list(string),
      blob_types   = list(string),
      object_rules = list(object({
        for_object           = string
        delete_in_days       = number
        move_to_cold_tier_in = number
        archive_in           = number
      }))
    })
  )
}
