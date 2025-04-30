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

variable "mssql_elasticpool_name" {
  description = "The name of the Azure SQL Elastic Pool."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Azure SQL Elastic Pool."
  type        = string
}

variable "location" {
  description = "The Azure region to deploy"
  type        = string
}

variable "mssql_server_name" {
  description = "The name of the SQL Server on which to create the Elastic Pool."
  type        = string
}

variable "elastic_pool_license_type" {
  default     = "LicenseIncluded"
  description = "The license type to apply for this Elastic Pool."
  type        = string
}

variable "elastic_pool_max_size_gb" {
  default     = 756
  description = "The maximum size in GB that the database can reach before it is stopped."
  type        = number
}

variable "elastic_pool_sku_name" {
  default     = "GP_Gen5"
  description = "The name of the Elastic Pool SKU."
  type        = string
}

variable "elastic_pool_sku_family" {
  default     = "Gen5"
  description = "The family of hardware Gen4, Gen5, Fsv2 or DC"
  type        = string
}

variable "elastic_pool_sku_tier" {
  default     = "GeneralPurpose"
  description = "The tier of the Elastic Pool."
  type        = string
}

variable "elastic_pool_sku_capacity" {
  default     = 4
  description = "The capacity of the Elastic Pool."
  type        = number
}

variable "elastic_pool_per_database_settings_min_capacity" {
  default     = 0.25
  description = "The minimum capacity all databases are guaranteed."
  type        = number
}

variable "elastic_pool_per_database_settings_max_capacity" {
  default     = 4
  description = "The maximum capacity any one database can consume."
  type        = number
}

variable "mssql_elasticpool_abbreviation" {
  description = "The abbreviation of the resource name."
  type        = string
  default     = "sqlep"
}

variable "maintenance_configuration_name" {
  description = "The name of the Public Maintenance Configuration window to apply to the elastic pool."
  type        = string
  default     = "SQL_Default"
}
