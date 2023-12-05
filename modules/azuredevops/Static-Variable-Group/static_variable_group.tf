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

resource "azuredevops_variable_group" "devops_variable_group" {
  project_id   = var.project_id
  name         = var.variable_group_name
  allow_access = var.allow_access

  dynamic "variable" {
    for_each = var.variables_map

    content {
      name  = variable.value["name"]
      value = variable.value["value"]
    }
  }

  dynamic "variable" {
    for_each = var.secrets_map

    content {
      name         = variable.value["name"]
      secret_value = variable.value["value"]
      is_secret    = var.is_secret
    }
  }

  lifecycle {
    ignore_changes = [
      variable
    ]
  }
}
