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

resource "azurerm_backup_policy_file_share" "backup_policy_file_share" {
  name                = join("-", [var.backup_policy_file_share_abbreviation, var.backup_policy_file_share_name])
  resource_group_name = var.resource_group_name
  recovery_vault_name = var.recovery_vault_name

  backup {
    frequency = "Daily"
    time      = var.daily_backup_time
  }

  retention_daily {
    count = var.daily_retention
  }
}
