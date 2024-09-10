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

resource "azurerm_api_management_policy_fragment" "api_policy_fragment_secondary" {
  api_management_id = var.secondary_api_management_id
  name              = join("-", [var.abbreviation, var.name])
  format            = var.file_format
  value             = templatefile(var.xml_template_file_path, var.xml_template_vars)
}
