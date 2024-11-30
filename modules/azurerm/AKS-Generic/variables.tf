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
  description = "Location identifier"
  type        = string
}

variable "aks_resource_group_name" {
  description = "Resource group to deploy the AKS Cluster"
  type        = string
}

variable "tags" {
  default     = {}
  description = "Tags of the AKS cluster"
  type        = map(string)
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics Workspace Resource id"
  type        = string
}

# Network details
variable "virtual_network_resource_group_name" {
  default     = null
  description = "Resource group of the Virtual Network"
  type        = string
}

variable "virtual_network_name" {
  description = "Virtual network name"
  type        = string
}

variable "aks_node_pool_subnet_address_prefix" {
  description = "Subnet CIDR for deploying the Nodepool"
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

variable "aks_nodepool_subnet_allowed_service_endpoints" {
  default     = ["Microsoft.Sql", "Microsoft.ContainerRegistry", "Microsoft.EventHub", "Microsoft.Storage"]
  description = "Service endpoints to be accessible to the Nodepool Subnet"
  type        = list(string)
}

variable "internal_loadbalancer_subnet_address_prefix" {
  description = "CIDR block of the internal load balancer subnet"
  type        = string
}

variable "aks_node_pool_subnet_nsg_rules" {
  default     = {}
  description = "NSG rules for the nodepool subnet"
  type = map(object({
    priority                                   = string
    name                                       = string
    description                                = string
    direction                                  = string
    access                                     = string
    protocol                                   = string
    source_port_range                          = string
    source_port_ranges                         = list(string)
    destination_port_range                     = string
    destination_port_ranges                    = list(string)
    source_address_prefix                      = string
    source_address_prefixes                    = list(string)
    destination_address_prefix                 = string
    destination_address_prefixes               = list(string)
    source_application_security_group_ids      = list(string)
    destination_application_security_group_ids = list(string)
  }))
}

variable "aks_load_balancer_subnet_nsg_rules" {
  default     = {}
  description = "NSG rules for the load balancer subnet"
  type = map(object({
    priority                                   = string
    name                                       = string
    description                                = string
    direction                                  = string
    access                                     = string
    protocol                                   = string
    source_port_range                          = string
    source_port_ranges                         = list(string)
    destination_port_range                     = string
    destination_port_ranges                    = list(string)
    source_address_prefix                      = string
    source_address_prefixes                    = list(string)
    destination_address_prefix                 = string
    destination_address_prefixes               = list(string)
    source_application_security_group_ids      = list(string)
    destination_application_security_group_ids = list(string)
  }))
}

variable "aks_node_pool_subnet_routes" {
  default     = {}
  description = "Routes for aks nodepool subnet"
  type = map(object({
    address_prefix         = string
    name                   = string
    next_hop_type          = string
    next_hop_in_ip_address = string
  }))
}

# Global AKS Configuration
variable "aks_admin_username" {
  description = "Admin Username for AKS nodes"
  type        = string
}

variable "aks_public_ssh_key_path" {
  description = "Public key path for AKS Nodes"
  type        = string
}

variable "aks_admin_group_object_ids" {
  default     = []
  description = "Group IDs of AKS Admins"
  type        = list(string)
}

variable "outbound_type" {
  default     = "userDefinedRouting"
  description = "Outbound type for the AKS cluster. Can be loadBalancer or userDefinedRouting"
  type        = string
}

variable "kubernetes_version" {
  description = "Version of Kubernetes"
  type        = string
}

variable "service_cidr" {
  description = "CIDR block for allocating K8S Services"
  type        = string
}

variable "dns_service_ip" {
  description = "DNS service IP Address"
  type        = string
}

variable "docker_bridge_cidr" {
  description = "CIDR block for the docker bridge"
  type        = string
}

variable "private_cluster_public_fqdn_enable" {
  default     = false
  description = "Flag for whether a public FQDN for this private cluster should be added."
  type        = bool
}

variable "http_application_routing_enabled" {
  default     = false
  description = "Flag to enable HTTP Application routing"
  type        = bool
}

variable "private_cluster_enabled" {
  default     = false
  description = "Enable private access to the cluster's API Server"
  type        = bool
}

variable "sku_tier" {
  default     = "Free"
  description = "Tier of the API Server"
  type        = string
}

variable "aks_azure_rbac_enabled" {
  default     = false
  description = "Role based access control based on azure AD enabled"
  type        = bool
}

# Default Nodepool Configurations
variable "default_node_pool_count" {
  description = "Number of nodes for the default system nodepool"
  type        = string
}

variable "default_node_pool_vm_size" {
  description = "VM Size for the default nodepool"
  type        = string
}

variable "default_node_pool_orchestrator_version" {
  description = "Kubernetes version for the default nodepool"
  type        = string
}

variable "default_node_pool_only_critical_addons_enabled" {
  description = "Flag to only use default nodepool for Critical workloads"
  type        = bool
}

variable "default_node_pool_availability_zones" {
  description = "Availability zones for the nodes of the default nodepool"
  type        = list(number)
}

variable "default_node_pool_os_disk_size_gb" {
  description = "OS Disk size of the nodes of the default nodepool"
  type        = number
}

variable "default_node_pool_os_disk_type" {
  default     = "Ephemeral"
  description = "OS Disk type of the nodes of the default nodepool. Can be Ephemeral or Managed"
  type        = string
}

variable "default_node_pool_enable_auto_scaling" {
  default     = true
  description = "Flag to enable auto scaling for the default nodepool"
  type        = bool
}

variable "default_node_pool_max_count" {
  description = "Maximum nodes for default nodepool when used with autoscaling"
  type        = number
}

variable "default_node_pool_min_count" {
  description = "Minimum nodes for default nodepool when used with autoscaling"
  type        = number
}

variable "default_node_pool_max_pods" {
  description = "Max number of pods to run on a single node in the default nodepool"
  type        = number
}

variable "default_node_pool_name" {
  description = "Default node pool name"
  type        = string
}

variable "azure_policy_enabled" {
  description = "Flag to enable Azure policies for the cluster"
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

variable "api_server_authorized_ip_ranges" {
  description = "List of authorized IP ranges for the Kubernetes API server"
  type        = list(string)
}
