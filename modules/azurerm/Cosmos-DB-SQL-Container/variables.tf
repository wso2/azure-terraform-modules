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
  description = "Partition key version."
  type        = number
  default     = 1
}

variable "autoscale_enabled" {
  description = "Is auto scale enable for the container."
  type        = bool
  default     = false
}

variable "throughput" {
  description = "Throughput of the partition."
  type        = number
  default     = 400
}

variable "unique_key_paths" {
  description = "A list of unique key path lists."
  type        = list(list(string))
  default     = []
}

variable "default_ttl" {
  description = "The default time to live of SQL container."
  type        = number
  default     = -1
}
