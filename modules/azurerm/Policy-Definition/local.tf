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

locals {
  raw_policy_data = var.raw_policy_definition_path != null ? jsondecode(file(var.raw_policy_definition_path)) : jsondecode(var.raw_policy_data)
  parameters      = jsonencode(local.raw_policy_data.properties.parameters)
  metadata        = jsonencode(local.raw_policy_data.properties.metadata)
  policy_rule     = jsonencode(local.raw_policy_data.properties.policyRule)
}
