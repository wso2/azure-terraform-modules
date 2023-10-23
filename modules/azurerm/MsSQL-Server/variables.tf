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

variable "default_tags" {}
variable "project" {}
variable "application_name" {}
variable "padding" {}
variable "environment" {}
variable "resource_group_name" {}
variable "location" {}
variable "db_server_version" {
  default = "12.0"
}
variable "db_server_administrator_login" {}
variable "db_server_administrator_login_password" {}
variable "db_server_minimum_tls_version" {
  default = "1.2"
}
variable "db_server_public_network_access_enabled" {
  default = false
}
variable "extended_auditing_policy_storage_account_access_key_is_secondary" {
  default = true
}
variable "extended_auditing_policy_retention_in_days" {
  default = 6
}

variable "mssql_identity_type" {
  type    = string
  default = "SystemAssigned"
}

variable "azuread_administrator_login_username" {
  type        = string
  description = "The login username of the Azure AD Administrator of this SQL Server"
}

variable "azuread_administrator_object_id" {
  type        = string
  description = "The object id of the Azure AD Administrator of this SQL Server"
}

variable "azuread_administrator_tenant_id" {
  type        = string
  description = "The tenant id of the Azure AD Administrator of this SQL Server"
}
