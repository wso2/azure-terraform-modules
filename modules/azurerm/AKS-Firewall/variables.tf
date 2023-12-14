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

variable "aks_cluster_name" {
  description = "AKS cluster name"
  type        = string
}

variable "aks_cluster_dns_prefix" {
  description = "AKS cluster dns prefix"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "virtual_network_name" {
  description = "Virtual network name"
  type        = string
}

variable "aks_node_pool_subnet_address_prefix" {
  description = "Subnet prefix of AKS node pool"
  type        = string
}

variable "aks_node_pool_resource_group_name" {
  description = "Resource group name of AKS node pool"
  type        = string
}

variable "aks_node_pool_subnet_name" {
  description = "Subnet name of AKS node pool"
  type        = string
}

variable "aks_node_pool_subnet_route_table_name" {
  description = "Route table name of AKS node pool"
  type        = string
}

variable "aks_load_balancer_subnet_name" {
  description = "Subnet name of AKS load balancer"
  type        = string
}

variable "aks_load_balancer_subnet_network_security_group_name" {
  description = "Network security group name of AKS load balancer"
  type        = string
}

variable "aks_node_pool_subnet_network_security_group_name" {
  description = "Network security group name of AKS node pool"
  type        = string
}

variable "tags" {
  description = "Tags for the resource"
  type        = map(string)
}

variable "aks_admin_username" {
  description = "Admin username for AKS"
  type        = string
}

variable "aks_public_ssh_key_path" {
  description = "Public ssh key path for AKS"
  type        = string
}

variable "aks_admin_group_object_ids" {
  default     = []
  description = "Admin group object ids for AKS"
  type        = list(string)
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
}

variable "default_node_pool_count" {
  description = "Default node pool count"
  type        = number
}

variable "default_node_pool_vm_size" {
  description = "Default node pool vm size"
  type        = string
}

variable "default_node_pool_orchestrator_version" {
  description = "Default node pool orchestrator version"
  type        = string
}

variable "default_node_pool_only_critical_addons_enabled" {
  description = "Enabling this option will taint default node pool with CriticalAddonsOnly=true:NoSchedule taint"
  type        = bool
}

variable "default_node_pool_availability_zones" {
  description = "Default node pool availability zones"
  type        = list(string)
}

variable "default_node_pool_os_disk_size_gb" {
  description = "Default node pool os disk size in GB"
  type        = number
}

variable "default_node_pool_os_disk_type" {
  default     = "Ephemeral"
  description = "Default node pool os disk type. Possible values are Ephemeral and Managed."
  type        = string
}

variable "default_node_pool_enable_auto_scaling" {
  default     = "true"
  description = "Default node pool enable auto scaling"
  type        = bool
}

variable "default_node_pool_max_count" {
  description = "Default node pool max count"
  type        = number
}

variable "default_node_pool_min_count" {
  description = "Default node pool min count"
  type        = number
}

variable "default_node_pool_max_pods" {
  description = "Default node pool max pods"
  type        = number
}

variable "api_server_authorized_ip_ranges" {
  description = "List of authorized IP ranges for the Kubernetes API server"
  type        = list(string)
}

variable "service_cidr" {
  description = "Service CIDR"
  type        = string
}

variable "dns_service_ip" {
  description = "DNS service IP"
  type        = string
}

variable "docker_bridge_cidr" {
  description = "Docker bridge CIDR"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "Log analytics workspace id"
  type        = string
}

variable "azure_policy_enabled" {
  description = "Enable Azure policy"
  type        = bool
}

variable "http_application_routing_enabled" {
  default     = false
  description = "Enable HTTP application routing"
  type        = bool
}

variable "sku_tier" {
  default     = "Free"
  description = "SKU tier of application gateway"
  type        = string
}

variable "firewall_subnet_address_prefix" {
  description = "Subnet prefix of firewall"
  type        = string
}

variable "private_cluster_enabled" {
  default     = false
  description = "Enable private cluster"
  type        = bool
}

variable "internal_loadbalancer_subnet_address_prefix" {
  description = "Subnet prefix of internal load balancer"
  type        = string
}

variable "firewall_private_ip" {
  description = "Private IP of firewall"
  type        = string
}

variable "application_gateway_subnet_address_prefix" {
  description = "Subnet prefix of application gateway"
  type        = string
}

variable "aks_azure_rbac_enabled" {
  default     = false
  description = "Role based access control based on azure AD enabled"
  type        = bool
}

variable "node_pool_name" {
  description = "Default node pool name"
  type        = string
}

variable "private_cluster_public_fqdn_enable" {
  default     = false
  description = "Specifies whether a public FQDN for this private cluster should be added."
  type        = bool
}

variable "aks_nodepool_subnet_enforce_private_link_endpoint_network_policies" {
  default     = false
  description = "Enable or Disable network policies for the private link endpoint on the aks nodepool subnet"
  type        = bool
}

variable "internal_load_balancer_subnet_enforce_private_link_endpoint_network_policies" {
  default     = false
  description = "Enable or Disable network policies for the private link endpoint on the internal load balancer subnet"
  type        = bool
}

variable "private_dns_zone_id" {
  description = "Private DNS zone id"
  type        = string
}

variable "identity_type" {
  description = "Identity type"
  type        = string
  default     = "SystemAssigned"
}

variable "user_assigned_identity_id" {
  description = "User assigned identity id"
  type        = string
  default     = ""
}

variable "user_assigned_identity_principal_id" {
  description = "User assigned identity principal id"
  type        = string
  default     = ""
}

variable "secret_rotation_enabled" {
  description = "Enable secret rotation"
  type        = bool
  default     = false
}
