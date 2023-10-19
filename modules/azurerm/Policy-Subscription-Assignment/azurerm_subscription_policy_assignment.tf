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
resource "azurerm_subscription_policy_assignment" "subscription_policy_assignment" {
  name = join("-", [
    var.project_short_name,
    var.environment_short_name,
    var.purpose
  ])
  subscription_id      = var.subscription_resource_id
  policy_definition_id = var.policy_definition_id
  description          = var.description
  display_name = join("", [
    "[${var.project}][${var.environment}]",
    var.display_name
  ])
  enforce = var.enforce

  dynamic "identity" {
    for_each = var.identity_type != null ? [1] : []
    content {
      type         = var.identity_type
      identity_ids = var.identity_ids
    }
  }

  dynamic "non_compliance_message" {
    for_each = var.non_compliance_message
    content {
      content                        = non_compliance_message.value["content"]
      policy_definition_reference_id = non_compliance_message.value["policy_definition_reference_id"]
    }
  }

  parameters = var.parameters
  location   = var.location
}
