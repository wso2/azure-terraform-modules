# -------------------------------------------------------------------------------------
#
# Copyright (c) 2025, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
#
# WSO2 LLC. licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the
# specific language governing permissions and limitations
# under the License.
#
# --------------------------------------------------------------------------------------

output "storage_account_name" {
  depends_on = [azurerm_storage_account.static_storage]
  value      = azurerm_storage_account.static_storage.name
}

output "storage_account_id" {
  depends_on = [azurerm_storage_account.static_storage]
  value      = azurerm_storage_account.static_storage.id
}

output "storage_account_primary_web_endpoint" {
  depends_on = [azurerm_storage_account.static_storage]
  value      = azurerm_storage_account.static_storage.primary_web_endpoint
}

output "storage_account_primary_web_host" {
  depends_on = [azurerm_storage_account.static_storage]
  value      = azurerm_storage_account.static_storage.primary_web_host
}

output "storage_account_secondary_web_endpoint" {
  depends_on = [azurerm_storage_account.static_storage]
  value      = azurerm_storage_account.static_storage.secondary_web_endpoint
}

output "cdn_profile_name" {
  depends_on = [azurerm_cdn_profile.cdn_profile]
  value      = azurerm_cdn_profile.cdn_profile.name
}

output "cdn_profile_id" {
  depends_on = [azurerm_cdn_profile.cdn_profile]
  value      = azurerm_cdn_profile.cdn_profile.id
}

output "cdn_endpoint_fqdn" {
  depends_on = [azurerm_cdn_endpoint.cdn_endpoint]
  value      = azurerm_cdn_endpoint.cdn_endpoint.fqdn
}

output "cdn_endpoint_id" {
  depends_on = [azurerm_cdn_endpoint.cdn_endpoint]
  value      = azurerm_cdn_endpoint.cdn_endpoint.id
}
