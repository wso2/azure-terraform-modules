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

resource "azurerm_recovery_services_vault" "recovery_services_vault" {
  name                = join("-", ["rsv", var.project, var.environment, var.location, var.padding])
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.rs_vault_sku
  tags                = var.default_tags

  soft_delete_enabled = true
}
