# -------------------------------------------------------------------------------------
#
# Copyright (c) 2024, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
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

resource "azurerm_frontdoor_custom_https_configuration" "custom_https_configuration" {
  frontend_endpoint_id              = var.frontend_endpoint_id
  custom_https_provisioning_enabled = true
  custom_https_configuration {
    certificate_source                         = var.certificate_source
    azure_key_vault_certificate_secret_name    = var.certificate_source == "AzureKeyVault" ? var.azure_key_vault_certificate_secret_name : null
    azure_key_vault_certificate_vault_id       = var.certificate_source == "AzureKeyVault" ? var.azure_key_vault_certificate_vault_id : null
    azure_key_vault_certificate_secret_version = var.certificate_source == "AzureKeyVault" ? var.azure_key_vault_certificate_secret_version : null
  }
}
