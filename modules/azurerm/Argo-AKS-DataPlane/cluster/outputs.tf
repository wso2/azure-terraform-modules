# -------------------------------------------------------------------------------------
#
# Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.this.name
}

output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.this.id
}

output "kubernetes_cluster_fqdn" {
  value = azurerm_kubernetes_cluster.this.fqdn
}

output "kubernetes_cluster_private_fqdn" {
  value = azurerm_kubernetes_cluster.this.private_fqdn
}

output "aks_oidc_issuer_url" {
  value = azurerm_kubernetes_cluster.this.oidc_issuer_url
}

output "virtual_network_name" {
  value = azurerm_virtual_network.this.name
}

output "stage_subnet_id" {
  value = azurerm_subnet.stage.id
}

output "prod_subnet_id" {
  value = azurerm_subnet.prod.id
}

output "bastion_host_id" {
  value = var.enable_bastion ? azurerm_bastion_host.this[0].id : null
}

output "deploy_identity_client_ids" {
  description = "Client ID per deploy_identities entry - annotate the matching ServiceAccount with azure.workload.identity/client-id: <this value>"
  value       = { for k, i in azurerm_user_assigned_identity.deploy_identity : k => i.client_id }
}

output "workflow_controller_artifacts_client_id" {
  description = "Client ID for the workflow-controller ServiceAccount's azure.workload.identity/client-id annotation - null unless enable_artifact_archiving is true. The pod also needs the azure.workload.identity/use: \"true\" label to get the token injected."
  value       = var.enable_artifact_archiving ? azurerm_user_assigned_identity.workflow_controller_artifacts[0].client_id : null
}

output "artifact_storage_account_name" {
  description = "Storage account Argo Workflows should archive logs/artifacts to - null unless enable_artifact_archiving is true"
  value       = var.enable_artifact_archiving ? azurerm_storage_account.argo_logs[0].name : null
}
