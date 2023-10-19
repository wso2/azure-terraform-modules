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

resource "azurerm_storage_account" "static_storage" {
  name                            = join("", ["st",local.st_name_without_prefix])
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_kind                    = "StorageV2"
  account_tier                    = var.account_tier
  account_replication_type        = var.account_replication_type
  min_tls_version                 = "TLS1_2"
  enable_https_traffic_only       = true
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public

  tags = var.storage_account_tags

  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }

  network_rules {
    default_action             = var.network_rules_default_action
    ip_rules                   = var.network_rules_ip_whitelist
    virtual_network_subnet_ids = var.network_rules_subnet_ids
  }

  static_website {
    index_document = var.index_document
    error_404_document = var.error_document
  }

}
