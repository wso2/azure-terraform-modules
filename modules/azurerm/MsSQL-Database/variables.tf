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

variable "mssql_database_name" {
  description = "The name of the Azure SQL Database."
  type        = string
}

variable "collation" {
  default     = "SQL_Latin1_General_CP1_CI_AS"
  description = "The collation of the database"
  type        = string
}

variable "server_id" {
  description = "The ID of the SQL Server on which to create the Database"
  type        = string
}

variable "read_scale" {
  default     = true
  description = "Boolean flag which controls if read scale is enabled for the database"
  type        = bool
}

variable "zone_redundant" {
  default     = false
  description = "Boolean flag which controls if zone redundancy is enabled for the database"
  type        = bool
}

variable "short_term_retention_policy_retention_days" {
  default     = 7
  description = "The number of days to retain backups for"
  type        = number
}

variable "tags" {
  description = "A mapping of tags which should be assigned to the resource."
  type        = map(string)
}

variable "elastic_pool_id" {
  description = "The ID of the Elastic Pool to which to add the Database"
  type        = string
}

variable "sku_name" {
  description = "The Name of the SKU used for this Key Vault."
  type        = string
}

variable "min_capacity" {
  default     = "0.5"
  description = "The minimum capacity of the elastic pool in DTUs or vcores."
  type        = string
}

variable "max_size_gb" {
  default     = 32
  description = "The max size of the database in gigabytes."
  type        = number
}

variable "auto_pause_delay_in_minutes" {
  default     = "-1"
  description = "The delay in minutes before the database is automatically paused. The default is -1 (disabled)."
  type        = string
}

variable "maintenance_configuration_name" {
  default     = "SQL_EastUS2_DB_1"
  description = "The name of the Public Maintenance Configuration window to apply to the database"
  type        = string
}
