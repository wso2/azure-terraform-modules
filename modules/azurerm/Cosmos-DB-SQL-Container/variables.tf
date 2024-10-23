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

variable "container_name" {
  description = "Name of the container."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group to deploy the container in."
  type        = string
}

variable "cosmos_db_account_name" {
  description = "Cosmos DB account name in which the container will be deployed."
  type        = string
}

variable "cosmos_db_name" {
  description = "Name of the container in which the container will be deployed."
  type        = string
}

variable "partition_key_path" {
  description = "Partition key path of the partition key."
  type        = string
}

variable "partition_key_version" {
  default     = 1
  description = "Partition key version."
  type        = number
}

variable "autoscale_enabled" {
  default     = false
  description = "Is auto scale enable for the container."
  type        = bool
}

variable "throughput" {
  default     = 400
  description = "Throughput of the partition."
  type        = number
}

variable "unique_key_paths" {
  default     = []
  description = "A list of unique key path lists."
  type        = list(list(string))
}

variable "default_ttl" {
  default     = -1
  description = "The default time to live of SQL container."
  type        = number
}

variable "analytical_storage_ttl" {
  default     = null
  description = "The default time to live of Analytical Storage for this SQL container"
  type        = number
}
