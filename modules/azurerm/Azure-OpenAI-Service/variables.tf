# -------------------------------------------------------------------------------------
#
# Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "kind" {
  description = "Specifies the type of Cognitive Service Account that should be created."
  type        = string
  default     = "OpenAI"
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "cognitive_account_abbreviation" {
  description = "The abbreviation for the name of the Azure Cognitive account."
  type        = string
  default     = "oai"
}

variable "cognitive_account_name" {
  description = "The name of the Azure Cognitive account."
  type        = string
}

variable "account_sku_name" {
  description = "The SKU name of the Azure Cognitive account."
  type        = string
}

variable "dynamic_throttling_enabled" {
  description = "Specifies whether to enable the dynamic throttling for this Cognitive Service Account."
  type        = bool
  default     = false
}

variable "outbound_network_access_restricted" {
  description = "Specifies whether outbound network access is restricted for the Cognitive Account"
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Specifies whether public network access is allowed for the Cognitive Account."
  type        = bool
  default     = false
}

variable "custom_subdomain_name" {
  description = "The subdomain name used for token-based authentication."
  type        = string
}

variable "cognitive_deployment_abbreviation" {
  description = "The abbreviation for the name of the Azure Cognitive Deployment."
  type        = string
  default     = "oai"
}

variable "rai_policy_name" {
  description = "Optional Parameter for the name of the RAI policy."
  type        = string
  default     = null
}

variable "version_upgrade_option" {
  description = "Deployment model version upgrade option."
  type        = string
  default     = "NoAutoUpgrade"
}

variable "tags" {
  description = "Default tag list"
  type        = map(string)
}

variable "azure_openai_deployments" {
  description = "Map of OpenAI deployments in the Azure Cognitive Account"
  type = map(object({
    cognitive_deployment_name = string
    cognitive_model_format    = string
    cognitive_model_name      = string
    cognitive_model_version   = string
    deployment_sku_name       = string
    deployment_sku_capacity   = string
  }))
}

variable "network_acls_enabled" {
  description = "Boolean flag to specify whether Network ACLs should be enabled for the Cognitive Account."
  type        = bool
  default     = false
}

variable "network_acls_default_action" {
  description = "The Default Action for the Network ACLs."
  type        = string
  default     = "Deny"
}

variable "network_acls_bypass" {
  description = "Specifies which traffic can bypass the network rules. Possible values are AzureServices and None."
  type        = string
  default     = "AzureServices"
}

variable "network_acls_ip_rules" {
  description = "One or more IP Addresses, or CIDR Blocks which should be able to access the Cognitive Account."
  type        = list(string)
  default     = []
}
