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

variable "vault_access_tenant_id" {
  description = "The Azure Active Directory Tenant ID used for authenticating requests to the Key Vault."
  type        = string
}

variable "vault_access_object_id" {
  description = "The Object ID of the Azure Active Directory Object to add to the Key Vault."
  type        = string
}

variable "vault_access_secret_permissions" {
  default     = []
  description = "The Secret Permissions to grant to the Azure Active Directory Object."
  type        = list(string)
}

variable "vault_access_certificate_permissions" {
  default     = []
  description = "The Certificate Permissions to grant to the Azure Active Directory Object."
  type        = list(string)
}

variable "vault_access_key_permissions" {
  default     = []
  description = "The Key Permissions to grant to the Azure Active Directory Object."
  type        = list(string)
}

variable "vault_access_storage_permissions" {
  default     = []
  description = "The Storage Permissions to grant to the Azure Active Directory Object."
  type        = list(string)
}

variable "key_vault_id" {
  default     = ""
  description = "value of the key_vault_id"
  type        = string
}

variable "" {}