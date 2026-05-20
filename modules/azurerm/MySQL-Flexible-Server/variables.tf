# -------------------------------------------------------------------------------------
#
# Copyright (c) 2026, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
#
# WSO2 LLC. licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the
# specific language governing permissions and limitations
# under the License.
#
# --------------------------------------------------------------------------------------

variable "mysql_server_abbreviation" {
  description = "Abbreviation for the MySQL Flexible Server name"
  type        = string
  default     = "mysql"
}

variable "mysql_server_name" {
  description = "Name of the MySQL Flexible Server"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which the MySQL Flexible Server will be created"
  type        = string
}

variable "location" {
  description = "Azure region where the MySQL Flexible Server will be created"
  type        = string
}

variable "administrator_login" {
  description = "Administrator login name for the MySQL Flexible Server"
  type        = string
}

variable "administrator_password" {
  description = "Administrator password for the MySQL Flexible Server"
  type        = string
  sensitive   = true
}

variable "backup_retention_days" {
  description = "The number of days to retain backups for the MySQL Flexible Server. Valid values are between 7 and 35."
  type        = number
  default     = 7
}

variable "create_mode" {
  description = "The mode to create the MySQL Flexible Server. Possible values are: 'Default', 'PointInTimeRestore', 'GeoRestore', 'Replica'"
  type        = string
  default     = "Default"
}

variable "geo_redundant_backup_enabled" {
  description = "Specifies whether geo-redundant backup is enabled for the MySQL Flexible Server. Possible values are: true, false"
  type        = bool
  default     = false
}

variable "private_dns_zone_id" {
  description = "The ID of the private DNS zone to link to the MySQL Flexible Server"
  type        = string
  default     = null
}

variable "public_network_access" {
  description = "Specifies whether public network access is allowed for the MySQL Flexible Server. Possible values are: 'Enabled', 'Disabled'"
  type        = string
  default     = "Disabled"
}

variable "replication_role" {
  description = "The replication role of the MySQL Flexible Server. Possible value is: 'None'"
  type        = string
  default     = "None"
}

variable "sku_name" {
  description = "The SKU name of the MySQL Flexible Server"
  type        = string
}

variable "mysql_version" {
  description = "The MySQL version of the MySQL Flexible Server"
  type        = string
}

variable "zone" {
  description = "The availability zone of the MySQL Flexible Server"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to assign to the MySQL Flexible Server"
  type        = map(string)
  default     = {}
}

variable "high_availability_enabled" {
  description = "Specifies whether high availability is enabled for the MySQL Flexible Server"
  type        = bool
  default     = false
}

variable "ha_mode" {
  description = "The high availability mode of the MySQL Flexible Server"
  type        = string
  default     = "ZoneRedundant"
}

variable "ha_standby_availability_zone" {
  description = "The availability zone for the standby server when high availability is enabled for the MySQL Flexible Server"
  type        = string
  default     = null
}

variable "storage_enabled" {
  description = "Specifies whether storage configuration is enabled for the MySQL Flexible Server"
  type        = bool
  default     = false
}

variable "storage_auto_grow_enabled" {
  description = "Specifies whether auto-grow is enabled for the MySQL Flexible Server storage"
  type        = bool
  default     = false
}

variable "storage_io_scaling_enabled" {
  description = "Specifies whether I/O scaling is enabled for the MySQL Flexible Server storage"
  type        = bool
  default     = false
}

variable "storage_iops" {
  description = "The number of IOPS for the MySQL Flexible Server storage when I/O scaling is enabled"
  type        = number
  default     = null
}

variable "storage_log_on_disk_enabled" {
  description = "Specifies whether log on disk is enabled for the MySQL Flexible Server storage"
  type        = bool
  default     = false
}

variable "storage_size_gb" {
  description = "The storage size in GB for the MySQL Flexible Server when storage configuration is enabled"
  type        = number
  default     = null
}

variable "subnet_abbreviation" {
  description = "Abbreviation for the subnet name"
  type        = string
  default     = "snet"
}

variable "subnet_name" {
  description = "Name of the subnet to be created for the MySQL Flexible Server"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the virtual network in which the subnet will be created for the MySQL Flexible Server"
  type        = string
}

variable "address_prefix" {
  description = "The address prefix for the subnet to be created for the MySQL Flexible Server"
  type        = list(string)
}

variable "service_endpoints" {
  description = "The list of Service endpoints to associate with the subnet to be created for the MySQL Flexible Server"
  type        = list(string)
  default     = []
}

variable "delegations" {
  description = "Delegation for the subnet to be created for the MySQL Flexible Server"
  type = list(object({
    name         = string,
    service_name = string,
    actions      = list(string)
  }))
  default = []
}
