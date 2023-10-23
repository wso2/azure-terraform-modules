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

variable "project" {}
variable "environment" {}
variable "location" {}
variable "resource_group_name" {}
variable "virtual_network_name" {}
variable "aks_node_pool_subnet_address_prefix" {}
variable "workload" {}
variable "padding" {}
variable "default_tags" {}

variable "aks_admin_username" {}

variable "aks_public_ssh_key_path" {}

variable "aks_admin_group_object_ids" {
  type    = list(string)
  default = []
}

variable "kubernetes_version" {}

variable "default_node_pool_count" {}

variable "default_node_pool_vm_size" {}

variable "default_node_pool_orchestrator_version" {}

variable "default_node_pool_only_critical_addons_enabled" {}

variable "default_node_pool_availability_zones" {}

variable "default_node_pool_os_disk_size_gb" {}

variable "default_node_pool_os_disk_type" {
  default = "Ephemeral"
}

variable "default_node_pool_enable_auto_scaling" {
  default = "true"
}

variable "default_node_pool_max_count" {}

variable "default_node_pool_min_count" {}

variable "default_node_pool_max_pods" {}

variable "oms_agent_enabled" {}

variable "kube_dashboard_enabled" {}

variable "api_server_authorized_ip_ranges" {}

variable "service_cidr" {}

variable "dns_service_ip" {}

variable "docker_bridge_cidr" {}

variable "aks_node_pool_subnet_nsg_bastion_asg_id" {}

variable "log_analytics_workspace_id" {}

variable "log_analytics_workspace_name" {}

variable "azure_policy_enabled" {}

variable "http_application_routing_enabled" {
  default = false
  type    = bool
}

variable "ingress_application_gateway_enabled" {
  default = false
  type    = bool
}

variable "sku_tier" {
  default = "Free"
}

variable "firewall_subnet_address_prefix" {}

variable "private_cluster_enabled" {
  default = false
}

variable "internal_loadbalancer_subnet_address_prefix" {}

variable "firewall_private_ip" {}

variable "application_gateway_subnet_address_prefix" {
  description = "Subnet prefix of application gateway"
  type        = string
}

variable "aks_azure_rbac_enabled" {
  description = "Role based access control based on azure AD enabled"
  type        = bool
  default     = false
}

variable "node_pool_name" {
  description = "Default node pool name"
  type        = string
}

variable "private_cluster_public_fqdn_enable" {
  description = "Specifies whether a public FQDN for this private cluster should be added."
  default     = false
}
