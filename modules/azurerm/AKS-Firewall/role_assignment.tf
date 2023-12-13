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

resource "azurerm_role_assignment" "network_contributor_role_assignment_subnet" {
  scope                = azurerm_subnet.aks_node_pool_subnet.id
  role_definition_name = "Network Contributor"
  principal_id         = var.identity_type == "SystemAssigned" ? azurerm_kubernetes_cluster.aks_cluster.identity[0].principal_id : var.user_assigned_identity_principal_id
  depends_on           = [azurerm_kubernetes_cluster.aks_cluster, azurerm_subnet.aks_node_pool_subnet]
}

resource "azurerm_role_assignment" "aks_network_contributor_role_assignment_loadbalancer_subnet" {
  scope                = azurerm_subnet.internal_load_balancer_subnet.id
  role_definition_name = "Network Contributor"
  principal_id         = var.identity_type == "SystemAssigned" ? azurerm_kubernetes_cluster.aks_cluster.identity[0].principal_id : var.user_assigned_identity_principal_id
  depends_on           = [azurerm_kubernetes_cluster.aks_cluster, azurerm_subnet.internal_load_balancer_subnet]
}
