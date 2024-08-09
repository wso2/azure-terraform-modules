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

output "api_operation_id" {
  value      = azurerm_api_management_api_operation.api_management_api_operation.id
  depends_on = [azurerm_api_management_api_operation.api_management_api_operation]
}

output "operation_id" {
  value      = azurerm_api_management_api_operation.api_management_api_operation.operation_id
  depends_on = [azurerm_api_management_api_operation.api_management_api_operation]
}

output "api_name" {
  value      = azurerm_api_management_api_operation.api_management_api_operation.api_name
  depends_on = [azurerm_api_management_api_operation.api_management_api_operation]
}

output "api_management_name" {
  value      = azurerm_api_management_api_operation.api_management_api_operation.api_management_name
  depends_on = [azurerm_api_management_api_operation.api_management_api_operation]
}

output "api_operation_policy_id" {
  value      = azurerm_api_management_api_operation_policy.api_management_api_operation_policy.id
  depends_on = [azurerm_api_management_api_operation_policy.api_management_api_operation_policy]
}
