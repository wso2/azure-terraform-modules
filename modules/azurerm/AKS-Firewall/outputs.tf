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

output "aks_node_pool_subnet_id" {
  depends_on = [azurerm_subnet.aks_node_pool_subnet]
  value      = azurerm_subnet.aks_node_pool_subnet.id
}

output "kubernetes_cluster_fqdn" {
  depends_on = [azurerm_kubernetes_cluster.aks_cluster]
  value      = azurerm_kubernetes_cluster.aks_cluster.fqdn
}

output "aks_cluster_name" {
  depends_on = [azurerm_kubernetes_cluster.aks_cluster]
  value      = azurerm_kubernetes_cluster.aks_cluster.name
}

output "aks_cluster_id" {
  depends_on = [azurerm_kubernetes_cluster.aks_cluster]
  value      = azurerm_kubernetes_cluster.aks_cluster.id
}

output "aks_kube_admin_config_raw" {
  depends_on = [azurerm_kubernetes_cluster.aks_cluster]
  value      = azurerm_kubernetes_cluster.aks_cluster.kube_admin_config_raw
}

output "kubernetes_cluster_private_fqdn" {
  depends_on = [azurerm_kubernetes_cluster.aks_cluster]
  value      = azurerm_kubernetes_cluster.aks_cluster.private_fqdn
}

output "aks_kubelet_identity" {
  depends_on = [azurerm_kubernetes_cluster.aks_cluster]
  value      = azurerm_kubernetes_cluster.aks_cluster.kubelet_identity[0].object_id
}

output "aks_api_server_identity" {
  depends_on = [azurerm_kubernetes_cluster.aks_cluster]
  value      = azurerm_kubernetes_cluster.aks_cluster.identity[0].principal_id
}

output "aks_internal_lb_subnet_id" {
  depends_on = [azurerm_subnet.internal_load_balancer_subnet]
  value      = azurerm_subnet.internal_load_balancer_subnet.id
}

output "nodepool_network_security_group_id" {
  depends_on = [azurerm_network_security_group.aks_node_pool_subnet_nsg]
  value      = azurerm_network_security_group.aks_node_pool_subnet_nsg.id
}

output "internal_load_balancer_network_security_group_id" {
  depends_on = [azurerm_network_security_group.internal_load_balancer_subnet_nsg]
  value      = azurerm_network_security_group.internal_load_balancer_subnet_nsg.id
}

output "nodepool_network_security_group_name" {
  depends_on = [azurerm_network_security_group.aks_node_pool_subnet_nsg]
  value      = azurerm_network_security_group.aks_node_pool_subnet_nsg.name
}

output "internal_load_balancer_network_security_group_name" {
  depends_on = [azurerm_network_security_group.internal_load_balancer_subnet_nsg]
  value      = azurerm_network_security_group.internal_load_balancer_subnet_nsg.name
}

output "node_resource_group" {
  depends_on = [azurerm_kubernetes_cluster.aks_cluster]
  value      = azurerm_kubernetes_cluster.aks_cluster.node_resource_group
}

output "oidc_issuer_url" {
  depends_on = [azurerm_kubernetes_cluster.aks_cluster]
  value      = azurerm_kubernetes_cluster.aks_cluster.oidc_issuer_url
}
