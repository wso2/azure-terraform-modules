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
  type        = string
  description = "The short name  of project to which the policy set definition is created"
}

variable "environment_short_name" {
  type        = string
  description = "The short name of the environment to which the policy set definition is created"
}

variable "project" {
  type        = string
  description = "The project to which the policy set definition is created"
}

variable "environment" {
  type        = string
  description = "The environment to which the policy set definition is created"
}

variable "purpose" {
  type        = string
  description = "The purpose of the policy set definition. Changing this forces a new resource to be created."
}

variable "policy_type" {
  type        = string
  description = "The policy set type. Possible values are BuiltIn, Custom, NotSpecified and Static. Changing this forces a new resource to be created."
}

variable "display_name" {
  type        = string
  description = "The display name of the policy set definition."
}

variable "description" {
  type        = string
  description = "The description of the policy definition."
}

variable "metadata" {
  type        = string
  description = "The metadata for the policy set definition. This is a JSON object representing additional metadata that should be stored with the policy definition."
  default     = ""
}

variable "policy_definition_reference" {
  type = list(object({
    policy_definition_id = string
    parameter_values     = string
    reference_id         = string
  }))
  description = <<EOT
    policy_definition_reference = {
      policy_definition_id : "The ID of the policy definition that will be included in this policy set definition."
      parameter_values : "Parameter values for the referenced policy rule. This field is a JSON string that allows you to assign parameters to this policy rule."
      reference_id : "A unique ID within this policy set definition for this policy definition reference."
    }
   EOT
}

variable "parameters" {
  type        = string
  description = "Parameters for the policy set definition. This field is a JSON object that allows you to parameterize your policy definition."
}
