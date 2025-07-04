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

output "client_id" {
  description = "The client ID of the Azure AD application."
  value       = azuread_application.ad_application.client_id
}

output "application_id" {
  description = "The resource ID of the Azure AD application."
  value       = azuread_application.ad_application.id
}

output "object_id" {
  description = "The object ID of the service principal."
  value       = azuread_service_principal.service_principal.object_id
}
