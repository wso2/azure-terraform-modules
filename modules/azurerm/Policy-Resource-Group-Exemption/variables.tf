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

variable "project_short_name" {
  description = "The short name  of project to which the policy exemption is created"
  type        = string
}

variable "environment_short_name" {
  description = "The short name of the environment to which the policy exemption is created"
  type        = string
}

variable "project" {
  description = "The project to which the policy exemption is created"
  type        = string
}

variable "environment" {
  description = "The environment to which the policy exemption is created"
  type        = string
}

variable "purpose" {
  description = "The purpose of the policy exemption. Changing this forces a new resource to be created"
  type        = string
}

variable "resource_group_id" {
  description = "The Resource group ID where the Policy Exemption should be applied. Changing this forces a new resource to be created."
  type        = string
}

variable "exemption_category" {
  default     = "Waiver"
  description = "The category of this policy exemption. Possible values are Waiver and Mitigated. Default is 'Waiver'."
  type        = string
}

variable "policy_assignment_id" {
  description = "The ID of the Policy Assignment to be exempted at the specified Scope. Changing this forces a new resource to be created."
  type        = string
}

variable "description" {
  description = "The description of the policy exemption."
  type        = string
}

variable "display_name" {
  description = "A friendly display name to use for this Policy Exemption."
  type        = string
}

variable "policy_definition_reference_ids" {
  default     = []
  description = "The policy definition reference ID list when the associated policy assignment is an assignment of a policy set definition."
  type        = list(string)
}
