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

variable "cosmos_sql_database_name" {
  description = "Name of the Cosmos SQL Database."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group to deploy the Cosmos SQL Database in."
  type        = string
}

variable "cosmos_db_account_name" {
  description = "Cosmos DB account name in which the Cosmos SQL Database will be deployed."
  type        = string
}

variable "is_autoscaled" {
  default     = false
  description = "Is auto scale enable for the Cosmos SQL Database."
  type        = bool
}

variable "throughput" {
  description = "Throughput of the Cosmos SQL Database."
  type        = number
}
