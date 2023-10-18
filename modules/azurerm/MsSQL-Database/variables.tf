# -------------------------------------------------------------------------------------
#
# Copyright (c) 2020, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "collation" {
  default = "SQL_Latin1_General_CP1_CI_AS"
}
variable "server_id" {

}
variable "read_scale" {
  default = true
}
variable "zone_redundant" {
  default = false
}
variable "short_term_retention_policy_retention_days" {
  default = 7
}

variable "application_name" {}
variable "workload" {}
variable "project" {}
variable "environment" {}
variable "tags" {}
variable "elastic_pool_id" {}
variable "sku_name" {}
variable "min_capacity" {
  default = "0.5"
}

variable "max_size_gb" {
  type        = number
  description = "The max size of the database in gigabytes."
  default     = 32
}

variable "auto_pause_delay_in_minutes" {
  default = "-1"
}

variable "maintenance_configuration_name" {
  description = "The name of the Public Maintenance Configuration window to apply to the database"
  default     = "SQL_EastUS2_DB_1"
  type        = string
}
