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
  name                            = join("", ["st", var.storage_account_name])
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = var.account_tier
  access_tier                     = var.access_tier
  account_replication_type        = var.account_replication_type
  min_tls_version                 = "TLS1_2"
  account_kind                    = "StorageV2"
  enable_https_traffic_only       = true
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public
  public_network_access_enabled   = var.public_network_access_enabled
  tags                            = var.tags

  blob_properties {

    delete_retention_policy {
      days = var.delete_retention_days_policy
    }
  }
}
