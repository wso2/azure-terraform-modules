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

resource "azurerm_storage_account" "storage_account" {
  name                            = join("", ["st", local.st_name_without_prefix])
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = var.account_tier
  access_tier                     = var.access_tier
  account_replication_type        = var.account_replication_type
  min_tls_version                 = "TLS1_2"
  account_kind                    = "StorageV2"
  enable_https_traffic_only       = true
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public
  tags                            = var.tags

  blob_properties {

    delete_retention_policy {
      days = var.delete_retention_days_policy
    }

    cors_rule {
      allowed_headers    = var.cors_allowed_header_list
      allowed_methods    = var.cors_allowed_methods_list
      allowed_origins    = var.cors_allowed_origins_list
      exposed_headers    = var.cors_exposed_headers_list
      max_age_in_seconds = var.cors_max_age_in_seconds
    }
  }
}
