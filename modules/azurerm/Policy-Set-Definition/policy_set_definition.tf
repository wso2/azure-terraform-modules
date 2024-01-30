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

resource "azurerm_policy_set_definition" "policy_set_definition" {
  name         = var.policy_set_definition_name
  policy_type  = var.policy_type
  display_name = var.policy_set_definition_display_name
  description  = var.description
  metadata     = var.metadata
  parameters   = var.parameters

  dynamic "policy_definition_reference" {
    for_each = var.policy_definition_reference

    content {
      policy_definition_id = policy_definition_reference.value["policy_definition_id"]
      parameter_values     = policy_definition_reference.value["parameter_values"]
      reference_id         = policy_definition_reference.value["reference_id"]
    }
  }
}
