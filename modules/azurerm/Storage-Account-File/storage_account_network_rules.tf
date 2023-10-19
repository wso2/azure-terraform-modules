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

resource "azurerm_storage_account_network_rules" "storage_account_network_rules" {
  storage_account_id = azurerm_storage_account.storage_account.id

  default_action             = var.storage_account_network_rules_default_action
  bypass                     = var.storage_account_network_rules_bypass
  ip_rules                   = var.storage_account_network_rules_ip_rules
  virtual_network_subnet_ids = var.storage_account_network_rules_virtual_network_subnet_ids
}
