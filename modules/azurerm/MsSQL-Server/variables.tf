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

variable "tags" {
  description = "Tags for the SQL Server"
  type        = map(string)
}

variable "project" {
  description = "The name of the project"
  type        = string
}

variable "application_name" {
  description = "The name of the application"
  type        = string
}

variable "padding" {
  description = "Padding for the deployment"
  type        = string
}

variable "environment" {
  description = "The name of the environment"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the SQL Server."
  type        = string
}

variable "location" {
  description = "The Azure region to deploy"
  type        = string
}

variable "db_server_version" {
  default     = "12.0"
  description = "The version of the database engine to use."
  type        = string
}

variable "db_server_administrator_login" {
  description = "The administrator login name for the SQL Server."
  type        = string
}

variable "db_server_administrator_login_password" {
  description = "The administrator login password for the SQL Server."
  type        = string
}

variable "db_server_minimum_tls_version" {
  default     = "1.2"
  description = "The minimum TLS version to support on the server."
  type        = string
}

variable "db_server_public_network_access_enabled" {
  default     = false
  description = "Whether or not public network access is allowed for this server."
  type        = bool
}

variable "mssql_identity_type" {
  default     = "SystemAssigned"
  description = "The type of identity used for the SQL Server."
  type        = string
}

variable "azuread_administrator_login_username" {
  description = "The login username of the Azure AD Administrator of this SQL Server"
  type        = string
}

variable "azuread_administrator_object_id" {
  description = "The object id of the Azure AD Administrator of this SQL Server"
  type        = string
}

variable "azuread_administrator_tenant_id" {
  description = "The tenant id of the Azure AD Administrator of this SQL Server"
  type        = string
}
