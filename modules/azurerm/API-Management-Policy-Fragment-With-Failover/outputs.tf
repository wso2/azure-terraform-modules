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

output "primary_policy_fragment_id" {
  value      = azurerm_api_management_policy_fragment.api_policy_fragment_primary.id
  depends_on = [azurerm_api_management_policy_fragment.api_policy_fragment_primary]
}

output "secondary_policy_fragment_id" {
  value      = azurerm_api_management_policy_fragment.api_policy_fragment_secondary.id
  depends_on = [azurerm_api_management_policy_fragment.api_policy_fragment_secondary]
}

output "primary_policy_fragment_name" {
  value      = azurerm_api_management_policy_fragment.api_policy_fragment_primary.name
  depends_on = [azurerm_api_management_policy_fragment.api_policy_fragment_primary]
}

output "secondary_policy_fragment_name" {
  value      = azurerm_api_management_policy_fragment.api_policy_fragment_secondary.name
  depends_on = [azurerm_api_management_policy_fragment.api_policy_fragment_secondary]
}
