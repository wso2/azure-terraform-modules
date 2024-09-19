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

variable "name" {
  description = "The name of the Policy Assignment"
  type        = string
}

variable "resource_group_resource_id" {
  description = "The Resource group resource ID to which the policy is scoped"
  type        = string
}

variable "policy_definition_id" {
  description = "The ID of the Policy Definition or Policy Definition Set. Changing this forces a new Policy Assignment to be created."
  type        = string
}

variable "display_name" {
  description = "The Display Name for this Policy Assignment."
  type        = string
}

variable "enforce" {
  description = "Specifies if this Policy should be enforced or not? Defaults to true"
  default     = true
  type        = bool
}

variable "description" {
  description = "A description which should be used for this Policy Assignment."
  type        = string
}

variable "non_compliance_message" {
  description = "Map of Non compliance messages"
  type = map(object({
    content                        = string
    policy_definition_reference_id = string
  }))
}

variable "identity_type" {
  description = "The Type of Managed Identity which should be added to this Policy Definition. Possible values are SystemAssigned, UserAssigned and null"
  type        = string
  default     = null
}

variable "identity_ids" {
  description = "A list of User Managed Identity IDs which should be assigned to the Policy Definition. This is required when identity_type is set to UserAssigned."
  type        = list(string)
  default     = []
}

variable "parameters" {
  description = "JSON encoded parameters with values for policy assignment(ex: jsonencode( {\"parameter1\": { \"value\": value1}})."
  default     = null
  type        = string
}

variable "location" {
  description = "The Azure Region where the Policy Assignment should exist. Changing this forces a new Policy Assignment to be created."
  type        = string
}
