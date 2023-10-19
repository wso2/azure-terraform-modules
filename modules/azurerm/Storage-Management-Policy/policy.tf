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

resource "azurerm_storage_management_policy" "storage_management_policy" {
  storage_account_id = var.storage_account_id

  dynamic rule {
    for_each = var.rules
    content {
      name = rule.key
      enabled = rule.value.enabled
      filters {
        blob_types = rule.value.blob_types
        prefix_match = rule.value.prefix_match
      }
      actions{
        dynamic base_blob{
          for_each = {
            for s in rule.value.object_rules : s.for_object => s if s.for_object == "blob"
          }
          content {
            tier_to_archive_after_days_since_modification_greater_than = base_blob.value.archive_in
            tier_to_cool_after_days_since_modification_greater_than = base_blob.value.move_to_cold_tier_in
            delete_after_days_since_modification_greater_than = base_blob.value.delete_in_days
          }
        }
        dynamic snapshot{
          for_each = {
            for s in rule.value.object_rules : s.for_object => s if s.for_object == "snapshot"
          }
          content {
            change_tier_to_archive_after_days_since_creation = snapshot.value.archive_in
            change_tier_to_cool_after_days_since_creation = snapshot.value.move_to_cold_tier_in
            delete_after_days_since_creation_greater_than =  snapshot.value.delete_in_days
          }
        }
        dynamic version{
          for_each = {
            for s in rule.value.object_rules : s.for_object => s if s.for_object == "version"
          }
          content {
            change_tier_to_archive_after_days_since_creation =  version.value.archive_in
            change_tier_to_cool_after_days_since_creation = version.value.move_to_cold_tier_in
            delete_after_days_since_creation =  version.value.delete_in_days
          }
        }
      }
    }
  }
}
