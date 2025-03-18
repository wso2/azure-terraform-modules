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

variable "federated_credential_abbreviation" {
  description = "Abbreviation for the Federated Identity Credential"
  type        = string
  default     = "fc"
}

variable "name" {
  description = "Name of the Federated Identity Credential"
  type        = string
}

variable "description" {
  description = "Description of the Federated Identity Credential"
  type        = string
}

variable "ad_application_id" {
  description = "The resource ID of the application for which this federated identity credential should be created."
  type        = string
}

variable "oidc_issuer_url" {
  description = "OIDC issuer url"
  type        = string
}

variable "audiences" {
  description = "Audience for the Federated Identity Credential"
  type        = list(string)
}

variable "subject" {
  description = "Subject for the Federated Identity Credential"
  type        = string
}
