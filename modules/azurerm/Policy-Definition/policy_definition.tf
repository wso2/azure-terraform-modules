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

resource "azurerm_policy_definition" "policy_definition" {
  name         = var.policy_definition_name
  policy_type  = var.policy_type
  mode         = var.mode
  display_name = var.policy_definition_display_name
  description  = var.description
  metadata     = local.metadata
  policy_rule  = local.policy_rule
  parameters   = local.parameters
}
