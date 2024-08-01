# -------------------------------------------------------------------------------------
#
# Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

resource "azurerm_api_management_api_operation" "api_management_api_operation_secondary" {
  operation_id        = join("-", [var.api_operation_abbreviation, var.api_operation_id])
  api_name            = var.api_name
  api_management_name = var.secondary_api_management_name
  resource_group_name = var.resource_group_name
  display_name        = var.display_name
  method              = var.method
  url_template        = var.url_template

  dynamic "template_parameter" {
    for_each = var.template_parameters

    content {
      name     = template_parameter.value.name
      type     = template_parameter.value.type
      required = template_parameter.value.required
      description = template_parameter.value.description
    }
  }
}

resource "azurerm_api_management_api_operation_policy" "api_management_api_operation_policy_secondary" {
  api_name            = azurerm_api_management_api_operation.api_management_api_operation_secondary.api_name
  api_management_name = azurerm_api_management_api_operation.api_management_api_operation_secondary.api_management_name
  resource_group_name = var.resource_group_name
  operation_id        = azurerm_api_management_api_operation.api_management_api_operation_secondary.operation_id
  xml_content         = templatefile(var.policy_xml_template_file_path, var.policy_xml_template_vars)
}
