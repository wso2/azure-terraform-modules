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

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "aks_cluster_name" {
  description = "AKS cluster name"
  type        = string
}

variable "federated_identity_name" {
  description = "AKS cluster name"
  type        = string
}

variable "azurerm_user_assigned_identity_principal_id" {
  description = "User assigned managed identity client ID"
  type        = string
}

variable "oidc_issuer_url" {
  description = "OIDC Url"
  type        = string
}
