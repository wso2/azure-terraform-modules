# -------------------------------------------------------------------------------------
#
# Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "default_tags" {}
variable "project" {}
variable "environment" {}
variable "resource_group_name" {}
variable "location" {}

variable "application_name" {}
variable "workload" {}
variable "mssql_server_name" {}
variable "elastic_pool_license_type" {
  default = "LicenseIncluded"
}
variable "elastic_pool_max_size_gb" {
  default = 756
}
variable "elastic_pool_sku_name" {
  default = "GP_Gen5"
}
variable "elastic_pool_sku_family" {
  description = "The family of hardware Gen4, Gen5, Fsv2 or DC"
  default     = "Gen5"
  type        = string
}
variable "elastic_pool_sku_tier" {
  default = "GeneralPurpose"
}
variable "elastic_pool_sku_capacity" {
  default = 4
}
variable "elastic_pool_per_database_settings_min_capacity" {
  default = 0.25
}
variable "elastic_pool_per_database_settings_max_capacity" {
  default = 4
}
