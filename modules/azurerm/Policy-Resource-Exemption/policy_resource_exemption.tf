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

resource "azurerm_resource_policy_exemption" "policy_exemption" {
  name                            = var.resource_policy_exemption_name
  resource_id                     = var.resource_id
  exemption_category              = var.exemption_category
  policy_assignment_id            = var.policy_assignment_id
  description                     = var.description
  display_name                    = var.resource_policy_exemption_display_name
  policy_definition_reference_ids = var.policy_definition_reference_ids
}
