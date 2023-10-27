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
  description = "Name of the node pool"
  type        = string
}

variable "node_pool_count" {
  description = "Number of nodes in the node pool"
  type        = number
}

variable "node_pool_vm_size" {
  description = "Size of the VMs in the node pool"
  type        = string
}

variable "node_pool_availability_zones" {
  default     = ["1", "2", "3"]
  description = "Availability zones of the node pool"
  type        = list(string)
}

variable "node_pool_os_disk_size_gb" {
  description = "Size of the OS disk in the node pool"
  type        = string
}

variable "node_pool_os_disk_type" {
  default     = "Ephemeral"
  description = "Type of the OS disk in the node pool. Valid values are Ephemeral and Managed"
  type        = string
}

variable "node_pool_enable_auto_scaling" {
  description = "Enable auto scaling for the node pool"
  type        = bool
}

variable "aks_subnet_id" {
  description = "Subnet ID of the AKS cluster"
  type        = string
}

variable "aks_cluster_id" {
  description = "ID of the AKS cluster"
  type        = string
}

variable "node_pool_max_count" {
  description = "Maximum number of nodes in the node pool"
  type        = number
}

variable "node_pool_min_count" {
  description = "Minimum number of nodes in the node pool"
  type        = number
}

variable "node_pool_max_pods" {
  description = "Maximum number of pods in the node pool"
  type        = number
}

variable "node_pool_orchestrator_version" {
  description = "Kubernetes version of the node pool"
  type        = string
}

variable "node_pool_mode" {
  default     = "User"
  description = "Mode of the node pool. Valid values are System and User"
  type        = string
}

variable "node_pool_os_type" {
  default     = "Linux"
  description = "OS type of the node pool. Valid values are Linux and Windows"
  type        = string
}

variable "tags" {
  description = "Tags to be used in the resource tags"
  type        = map(string)
}
