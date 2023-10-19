
# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "storage_account_id" {
  description = "Specifies the id of the storage account to apply the management policy to"
}

variable "rules" {
  type = map(
    object({
      enabled = bool,
      prefix_match = list(string),
      blob_types = list(string),
      object_rules = list(object({
        for_object = string
        delete_in_days = number
        move_to_cold_tier_in = number
        archive_in = number
      }))
    })
  )
  description = <<EOT
    rules = {
      enabled : "Boolean to specify whether the rule is enabled"
      prefix_match : "An array of strings for prefixes to be matched"
      blob_types : "An array of predefined values. Valid options are blockBlob and appendBlob"
      delete_in_days : "The age in days after last modification to delete the blob. Must be between 0 and 99999"
      move_to_cold_tier_in : "The age in days after last modification to tier blobs to cool storage. Supports blob currently at Hot tier. Must be between 0 and 99999"
      archive_in : "The age in days after last modification to tier blobs to archive storage. Supports blob currently at Hot or Cool tier. Must be between 0 and 99999."
    }
  EOT
}
