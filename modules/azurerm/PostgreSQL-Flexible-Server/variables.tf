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

variable "server_name" {
  description = "Name of the PostgreSQL Server"
  type        = string
}

variable "resource_group_name" {
  description = "Resouce Group name for PostgreSQL Server deployment"
  type        = string
}

variable "geo_redundant_backup_enabled" {
  default     = false
  description = "Enable Geo redundant backups on the PostgreSQL Server"
  type        = bool
}

variable "backup_retention_days" {
  default     = "7"
  description = "Number of days to store backups. Must be between 7 and 35"
  type        = string
}

variable "subnet_id" {
  default     = null
  description = "Optional Parameter to associate Server with a Subnet"
  type        = string
}

variable "private_dns_zone_id" {
  default     = null
  description = "Optional Parameter to associate Server with a DNS Zone, required when integrating with a Subnet"
  type        = string
}

variable "availability_zone" {
  default     = null
  description = "Optional Parameter to choose a specific availability zone for deployment. If not provided Azure will choose a preferred zone"
  type        = string
}

variable "tags" {
  default     = {}
  description = "Optional tags for the PostgreSQL Server deployment"
  type        = map(string)
}

variable "location" {
  description = "Location for PostgreSQL Server deployment"
  type        = string
}

variable "postgresql_server_version" {
  description = "PostgreSQL Server version, Must be 11,12,13 or 14"
  type        = string
  default     = null
}

variable "postgresql_server_admin_username" {
  description = "Admin account username"
  type        = string
  default     = null
}

variable "postgresql_server_admin_password" {
  description = "Admin account password"
  type        = string
  sensitive   = true
  default     = null
}

variable "storage_size" {
  description = "Storage account size in MB. Minimum is 32GB and Max is 32TB"
  type        = string
}

variable "sku_name" {
  description = "PostgreSQL Server version"
  type        = string
}

variable "maintainance_start_day" {
  default     = 0
  description = "Day to commence server updates, 0 = Sunday, 6 = Saturday"
  type        = number
}

variable "maintainance_start_hour" {
  default     = 0
  description = "Hour to commence server updates, value should be between 0 - 23"
  type        = number
}

variable "maintainance_start_minute" {
  default     = 0
  description = "Minute to commence server updates, value should be between 0 - 59"
  type        = number
}

variable "create_mode" {
  default     = "Default"
  description = "The creation mode which can be used to restore or replicate existing servers. Possible values are Default, GeoRestore, PointInTimeRestore, Replica and Update. Changing this forces a new PostgreSQL Flexible Server to be created"
  type        = string
}

variable "source_server_id" {
  default     = null
  description = "Optional Parameter to create a server as a replica of an existing server"
  type        = string
}

variable "high_availability" {
  default     = null
  description = "The high availability mode for the PostgreSQL Flexible Server. Possible value are SameZone or ZoneRedundant"
  type = object({
    mode = string
    standby_availability_zone = any
  })
}
