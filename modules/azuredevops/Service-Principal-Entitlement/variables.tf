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

variable "sp_object_id" {
  description = "The object ID of the service principal"
  type        = string
}

variable "account_license_type" {
  description = "The Azure DevOps account license type to assign to the service principal. Valid values: advanced, earlyAdopter, express (Basic), none, professional, stakeholder."
  type        = string
  default     = "express"

  validation {
    condition     = contains(["advanced", "earlyAdopter", "express", "none", "professional", "stakeholder"], var.account_license_type)
    error_message = "account_license_type must be one of: advanced, earlyAdopter, express, none, professional, stakeholder."
  }
}
