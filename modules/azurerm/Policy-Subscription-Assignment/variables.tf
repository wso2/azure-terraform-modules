# -------------------------------------------------------------------------------------
#
# Copyright (c) 2023, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "assignment_name" {
  type        = string
  description = "Subscription Policy Assignment Name"
}

variable "assignment_display_name" {
  type        = string
  description = "Subscription Policy Assignment Display Name"
}

variable "subscription_resource_id" {
  type        = string
  description = "The subscription resource ID to which the policy is scoped. ex: /subscriptions/<ID>."
}

variable "policy_definition_id" {
  type        = string
  description = "The ID of the Policy Definition or Policy Definition Set. Changing this forces a new Policy Assignment to be created."
}

variable "enforce" {
  default     = true
  type        = bool
  description = "Specifies if this Policy should be enforced or not? Defaults to true"
}

variable "description" {
  type        = string
  description = "A description which should be used for this Policy Assignment."
}

variable "non_compliance_message" {
  description = "Map of Non compliance messages"
  type = map(object({
    content                        = string
    policy_definition_reference_id = string
  }))
}

variable "identity_type" {
  default     = null
  type        = string
  description = "The Type of Managed Identity which should be added to this Policy Definition. Possible values are SystemAssigned, UserAssigned and null"
}

variable "identity_ids" {
  default     = []
  type        = list(string)
  description = "A list of User Managed Identity IDs which should be assigned to the Policy Definition. This is required when identity_type is set to UserAssigned."
}

variable "parameters" {
  default     = null
  type        = string
  description = "JSON encoded parameters with values for policy assignment(ex: jsonencode( {\"parameter1\": { \"value\": value1}})."
}

variable "location" {
  type        = string
  description = "The Azure Region where the Policy Assignment should exist. Changing this forces a new Policy Assignment to be created."
}
