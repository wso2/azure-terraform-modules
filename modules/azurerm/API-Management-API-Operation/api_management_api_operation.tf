/*
 * Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com).
 *
 * WSO2 LLC. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

resource "azurerm_api_management_api_operation" "api_management_api_operation" {
  operation_id        = join("-", [var.api_operation_abbreviation, var.api_operation_id])
  api_name            = var.api_name
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
  display_name        = var.display_name
  method              = var.method
  url_template        = var.url_template

  dynamic "template_parameter" {
    for_each = var.template_parameters

    content {
      name        = template_parameter.value.name
      type        = template_parameter.value.type
      required    = template_parameter.value.required
      description = template_parameter.value.description
    }
  }
}

resource "azurerm_api_management_api_operation_policy" "api_management_api_operation_policy" {
  api_name            = azurerm_api_management_api_operation.api_management_api_operation.api_name
  api_management_name = azurerm_api_management_api_operation.api_management_api_operation.api_management_name
  resource_group_name = var.resource_group_name
  operation_id        = azurerm_api_management_api_operation.api_management_api_operation.operation_id
  xml_content         = templatefile(var.policy_xml_template_file_path, var.policy_xml_template_vars)
}
