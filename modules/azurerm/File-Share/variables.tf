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

variable "project" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Name of the environment"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the File Share."
  type        = string
}

variable "tags" {
  description = "Tags for the File Share."
  type        = map(string)
}

variable "storage_account_name" {
  description = "The name of the storage account in which to create the File Share."
  type        = string
}

variable "scope" {
  description = "The scope at which the File Share should be created."
  type        = string
}

variable "file_share_quote" {
  description = "The maximum size of the File Share in GB."
  type        = number
}

variable "recovery_services_vault_name" {
  description = "The name of the Recovery Services Vault in which to create the Backup Policy."
  type        = string
}

variable "backup_container_storage_account_id" {
  description = "The ID of the Storage Account in which to create the Backup Container."
  type        = string
}

variable "backup_policy_file_share_id" {
  description = "The ID of the File Share for which to create the Backup Policy."
  type        = string
}
