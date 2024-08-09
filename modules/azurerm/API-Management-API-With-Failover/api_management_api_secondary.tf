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

resource "azurerm_api_management_api" "api_management_api_secondary" {
  name                  = join("-", [var.api_abbreviation, var.api_name])
  api_management_name   = var.secondary_api_management_name
  resource_group_name   = var.resource_group_name
  revision              = var.api_revision
  api_type              = var.api_type
  display_name          = var.display_name
  path                  = var.path
  protocols             = var.protocols
  service_url           = var.backend_service_url
  subscription_required = var.subscription_required
}

resource "azurerm_api_management_api_policy" "api_management_api_policy_secondary" {
  api_name            = azurerm_api_management_api.api_management_api_secondary.name
  api_management_name = var.secondary_api_management_name
  resource_group_name = var.resource_group_name
  xml_content         = templatefile(var.xml_template_file_path, var.xml_template_vars)
}
