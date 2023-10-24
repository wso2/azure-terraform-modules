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
  description = "The short name  of project to which the policy set definition is created"
  type        = string
}

variable "environment_short_name" {
  description = "The short name of the environment to which the policy set definition is created"
  type        = string
}

variable "project" {
  description = "The project to which the policy set definition is created"
  type        = string
}

variable "environment" {
  description = "The environment to which the policy set definition is created"
  type        = string
}

variable "purpose" {
  description = "The purpose of the policy set definition. Changing this forces a new resource to be created."
  type        = string
}

variable "policy_type" {
  description = "The policy set type. Possible values are BuiltIn, Custom, NotSpecified and Static. Changing this forces a new resource to be created."
  type        = string
}

variable "display_name" {
  description = "The display name of the policy set definition."
  type        = string
}

variable "description" {
  description = "The description of the policy definition."
  type        = string
}

variable "metadata" {
  default     = ""
  description = "The metadata for the policy set definition. This is a JSON object representing additional metadata that should be stored with the policy definition."
  type        = string
}

variable "policy_definition_reference" {
  description = "The policy definition reference block."
  type = list(object({
    policy_definition_id = string
    parameter_values     = string
    reference_id         = string
  }))
}

variable "parameters" {
  description = "Parameters for the policy set definition. This field is a JSON object that allows you to parameterize your policy definition."
  type        = string
}
