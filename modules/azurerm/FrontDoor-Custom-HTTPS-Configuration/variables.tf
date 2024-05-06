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

variable "frontend_endpoint_id" {
  description = "The id of the frontend enpoint"
  type        = string
}

variable "certificate_source" {
  description = "Certificate source to encrypted HTTPS traffic with. Only valid entries are FrontDoor and AzureKeyVault"
  type        = string
  default     = "FrontDoor"
}

variable "azure_key_vault_certificate_vault_id" {
  description = "(Optional) The ID of the Key Vault containing the SSL certificate. Required only if certificate source is AzureKeyVault"
  type        = string
  default     = null
}

variable "azure_key_vault_certificate_secret_name" {
  description = "(Optional) The name of the Key Vault secret representing the full certificate PFX.Required only if certificate source is AzureKeyVault"
  type        = string
  default     = null
}

variable "azure_key_vault_certificate_secret_version" {
  description = "(Optional) The version of the Key Vault secret representing the full certificate PFX. Required only if certificate source is AzureKeyVault"
  type        = string
  default     = null
}
