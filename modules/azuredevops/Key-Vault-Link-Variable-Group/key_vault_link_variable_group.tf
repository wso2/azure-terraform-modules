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
  name         = join("-", [var.project, var.name])
  allow_access = var.allow_access

  key_vault {
    name                = var.key_vault_name
    service_endpoint_id = var.key_vault_service_endpoint_id
  }

  dynamic "variable" {
    for_each = var.key_vault_secrets_name_list

    content {
      name = variable.value
    }
  }
}
