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

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                                = join("-", ["aks", var.aks_cluster_name])
  location                            = var.location
  resource_group_name                 = var.aks_resource_group_name
  dns_prefix                          = join("-", ["aks", var.aks_cluster_dns_prefix])
  kubernetes_version                  = var.kubernetes_version
  node_resource_group                 = join("-", ["rg", var.aks_node_pool_resource_group_name])
  sku_tier                            = var.sku_tier
  private_cluster_enabled             = var.private_cluster_enabled
  private_cluster_public_fqdn_enabled = var.private_cluster_public_fqdn_enable
  role_based_access_control_enabled   = true
  azure_policy_enabled                = var.azure_policy_enabled
  http_application_routing_enabled    = var.http_application_routing_enabled
  tags                                = var.tags
  depends_on = [
    azurerm_subnet.aks_node_pool_subnet
  ]

  linux_profile {
    admin_username = var.aks_admin_username
    ssh_key {
      key_data = file(var.aks_public_ssh_key_path)
    }
  }

  default_node_pool {
    name                         = join("", ["aksnp", var.default_node_pool_name])
    node_count                   = var.default_node_pool_count
    vm_size                      = var.default_node_pool_vm_size
    zones                        = var.default_node_pool_availability_zones
    os_disk_size_gb              = var.default_node_pool_os_disk_size_gb
    os_disk_type                 = var.default_node_pool_os_disk_type
    auto_scaling_enabled         = var.default_node_pool_enable_auto_scaling
    vnet_subnet_id               = azurerm_subnet.aks_node_pool_subnet.id
    max_count                    = var.default_node_pool_max_count
    min_count                    = var.default_node_pool_min_count
    max_pods                     = var.default_node_pool_max_pods
    orchestrator_version         = var.default_node_pool_orchestrator_version
    node_public_ip_enabled       = false
    only_critical_addons_enabled = var.default_node_pool_only_critical_addons_enabled
  }

  identity {
    type = "SystemAssigned"
  }

  azure_active_directory_role_based_access_control {
    admin_group_object_ids = var.aks_admin_group_object_ids
    azure_rbac_enabled     = var.aks_azure_rbac_enabled
  }

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "calico"
    load_balancer_sku = "standard"
    service_cidr      = var.service_cidr
    dns_service_ip    = var.dns_service_ip
    outbound_type     = var.outbound_type
  }

  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count,
      windows_profile,
      kubernetes_version,
      default_node_pool[0].orchestrator_version,
    ]
  }
}
