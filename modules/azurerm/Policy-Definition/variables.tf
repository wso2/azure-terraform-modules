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


variable "display_name" {
  description = "The display name of the policy definition."
  type        = string
}

variable "policy_definition_name" {
  description = "The name of the policy definition."
  type        = string
}

variable "policy_type" {
  description = "The policy type. Possible values are BuiltIn, Custom, NotSpecified and Static. Changing this forces a new resource to be created."
  type        = string
}

variable "mode" {
  default     = "Indexed"
  description = "The policy resource manager mode that allows you to specify which resource types will be evaluated. Possible values are All, Indexed, Microsoft.ContainerService.Data, Microsoft.CustomerLockbox.Data, Microsoft.DataCatalog.Data, Microsoft.KeyVault.Data, Microsoft.Kubernetes.Data, Microsoft.MachineLearningServices.Data, Microsoft.Network.Data and Microsoft.Synapse.Data."
  type        = string
}

variable "description" {
  description = "The description of the policy definition."
  type        = string
}

variable "raw_policy_definition_path" {
  description = "The path to the policy definition. The policy should to constructed according to the JSON schema https://schema.management.azure.com/schemas/2020-10-01/policyDefinition.json"
  type        = string
  default     = ""
}

variable "raw_policy_data" {
  description = "The raw policy data."
  type        = string
}
