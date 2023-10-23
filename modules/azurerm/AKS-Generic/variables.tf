# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

# Global details
variable "project" {
  type = string
  description = "Project name"
}
variable "environment" {
  type = string
  description = "Environment name"
}
variable "location" {
  type = string
  description = "Location identifier"
}
variable "aks_resource_group_name" {
  type = string
  description = "Resource group to deploy the AKS Cluster"
}
variable "workload" {
  type = string
  description = "Purpose of the cluster within the project"
}
variable "padding" {
  type = string
  description = "Padding to differentiate between resources"
}
variable "default_tags" {
  type = map(string)
  description = "Tags of the AKS cluster"
  default = {}
}

# Log analytics details
variable "log_analytics_resource_group_name" {
  type = string
  description = <<EOF
    Resource group of the Log analytics workspace
    Defaults to aks_resource_group_name if not provided
  EOF
  default = null
}
variable "log_analytics_workspace_id" {
  type = string
  description = "Log Analytics Workspace Resource id"
}
variable "log_analytics_workspace_name" {
  type = string
  description = "Log Analytics Workspace Resource name"
}

# Network details
variable "virtual_network_resource_group_name" {
  type = string
  description = <<EOF
    Resource group of the Virtual Network
    Defaults to aks_resource_group_name if not provided
  EOF
  default = null
}
variable "virtual_network_name" {
  type = string
  description = "Virtual network name"
}
variable "aks_node_pool_subnet_address_prefix" {
  type = string
  description = "Subnet CIDR for deploying the Nodepool"
}
variable  "aks_nodepool_subnet_allowed_service_endpoints" {
  type    = list(string)
  description = "Service endpoints to be accessible to the Nodepool Subnet"
  default = ["Microsoft.Sql", "Microsoft.ContainerRegistry", "Microsoft.EventHub", "Microsoft.Storage"]
}
variable "internal_loadbalancer_subnet_address_prefix" {
  description = "CIDR block of the internal load balancer subnet"
  type = string
}
variable "aks_node_pool_subnet_nsg_rules" {
  type = map(object({
    priority = string
    name = string
    description = string
    direction = string
    access = string
    protocol = string
    source_port_range = string
    source_port_ranges = list(string)
    destination_port_range = string
    destination_port_ranges = list(string)
    source_address_prefix = string
    source_address_prefixes = list(string)
    destination_address_prefix = string
    destination_address_prefixes = list(string)
    source_application_security_group_ids = list(string)
    destination_application_security_group_ids = list(string)
  }))
  description = "NSG rules for the nodepool subnet"
  default = {}
}
variable "aks_load_balancer_subnet_nsg_rules" {
  type = map(object({
    priority = string
    name = string
    description = string
    direction = string
    access = string
    protocol = string
    source_port_range = string
    source_port_ranges = list(string)
    destination_port_range = string
    destination_port_ranges = list(string)
    source_address_prefix = string
    source_address_prefixes = list(string)
    destination_address_prefix = string
    destination_address_prefixes = list(string)
    source_application_security_group_ids = list(string)
    destination_application_security_group_ids = list(string)
  }))
  description = "NSG rules for the load balancer subnet"
  default = {}
}
variable "aks_node_pool_subnet_routes" {
  type = map(object({
    address_prefix = string
    name = string
    next_hop_type = string
    next_hop_in_ip_address = string
  }))
  description = "Routes for aks nodepool subnet"
  default = {}
}
# Global AKS Configuration
variable "aks_admin_username" {
  type = string
  description = "Admin Username for AKS nodes"
}
variable "aks_public_ssh_key_path" {
  type = string
  description = "Public key path for AKS Nodes"
}
variable "aks_admin_group_object_ids" {
  type    = list(string)
  default = []
  description = "Group IDs of AKS Admins"
}
variable "outbound_type" {
  type = string
  default = "userDefinedRouting"
}
variable "kubernetes_version" {
  type    = string
  description = "Version of Kubernetes"
}
variable "api_server_authorized_ip_ranges" {
  type    = string
  description = "IP ranges authorized to access the API Server"
}
variable "service_cidr" {
  type    = string
  description = "CIDR block for allocating K8S Services"
}
variable "dns_service_ip" {
  type    = string
  description = "DNS service IP Address"
}
variable "docker_bridge_cidr" {
  type    = string
  description = "CIDR block for the docker bridge"
}
variable "private_cluster_public_fqdn_enable" {
  type = bool
  description = "Flag for whether a public FQDN for this private cluster should be added."
  default = false
}
variable "http_application_routing_enabled" {
  default = false
  type    = bool
  description = "Flag to enable HTTP Application routing"
}
variable "ingress_application_gateway_enabled" {
  default = false
  description = "Flag to enable Application Gateway Ingress"
  type    = bool
}
variable "private_cluster_enabled" {
  type = bool
  description = "Enable private access to the cluster's API Server"
  default = false
}
variable "sku_tier" {
  type = string
  description = "Tier of the API Server"
  default = "Free"
}
variable "aks_azure_rbac_enabled" {
  description = "Role based access control based on azure AD enabled"
  type = bool
  default = false
}

# Default Nodepool Configurations
variable "default_node_pool_count" {
  type    = string
  description = "Number of nodes for the default system nodepool"
}
variable "default_node_pool_vm_size" {
  type    = string
  description = "VM Size for the default nodepool"
}
variable "default_node_pool_orchestrator_version" {
  type    = string
  description = "Kubernetes version for the default nodepool"
}
variable "default_node_pool_only_critical_addons_enabled" {
  type    = bool
  description = "Flag to only use default nodepool for Critical workloads"
}
variable "default_node_pool_availability_zones" {
  type    = list(number)
  description = "Availability zones for the nodes of the default nodepool"
}
variable "default_node_pool_os_disk_size_gb" {
  type    = number
  description = "OS Disk size of the nodes of the default nodepool"
}
variable "default_node_pool_os_disk_type" {
  type    = string
  description = "OS Disk type of the nodes of the default nodepool. Can be Ephemeral or Managed"
  default = "Ephemeral"
}
variable "default_node_pool_enable_auto_scaling" {
  type    = bool
  description = "Flag to enable auto scaling for the default nodepool"
  default = true
}
variable "default_node_pool_max_count" {
  type    = number
  description = "Maximum nodes for default nodepool when used with autoscaling"
}
variable "default_node_pool_min_count" {
  type    = number
  description = "Minimum nodes for default nodepool when used with autoscaling"
}
variable "default_node_pool_max_pods" {
  type    = number
  description = "Max number of pods to run on a single node in the default nodepool"
}
variable "default_node_pool_name" {
  description = "Default node pool name"
  type = string
}

# Add Ons configuration
variable "oms_agent_enabled" {
  type    = bool
  description = "Flag to enable OMS Agent on the Cluster"
}
variable "kube_dashboard_enabled" {
  type    = bool
  description = "Flag to enable the Dashboard on the Cluster"
}
variable "azure_policy_enabled" {
  type    = bool
  description = "Flag to enable Azure policies for the cluster"
}
