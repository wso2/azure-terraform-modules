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

resource "azurerm_role_definition" "role_definition" {
  name              = var.role_definition_name
  scope             = var.role_definition_scope
  description       = var.description
  assignable_scopes = var.assignable_scopes

  permissions {
    actions          = var.allowed_actions_list
    not_actions      = var.disallowed_actions_list
    data_actions     = var.allowed_data_actions_list
    not_data_actions = var.disallowed_data_actions_list
  }
}
