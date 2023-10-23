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

variable "node_pool_name" {
  type = string
}

variable "node_pool_count" {
  type = number
}

variable "node_pool_vm_size" {
  type = string
}

variable "node_pool_availability_zones" {
  description = "Zones to use"
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "node_pool_os_disk_size_gb" {
  type = string
}

variable "node_pool_os_disk_type" {
  type    = string
  default = "Ephemeral"
}

variable "node_pool_enable_auto_scaling" {
  type = string
}

variable "aks_subnet_id" {
  type = string
}

variable "aks_cluster_id" {
  type = string
}

variable "node_pool_max_count" {
  type = number
}

variable "node_pool_min_count" {
  type = number
}

variable "node_pool_max_pods" {
  type = number
}

variable "node_pool_orchestrator_version" {
  type = string
}

variable "node_pool_mode" {
  type    = string
  default = "User"
}

variable "node_pool_os_type" {
  type    = string
  default = "Linux"
}

variable "default_tags" {}
