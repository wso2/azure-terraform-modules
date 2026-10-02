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

output "resource_group_name" {
  value = local.resource_group_name
}

output "virtual_network_name" {
  value = azurerm_virtual_network.this.name
}

output "node_subnet_id" {
  value = azurerm_subnet.nodes.id
}

output "nat_gateway_public_ip" {
  description = "Outbound IP for all control-plane egress - allowlist this on anything the control plane calls out to"
  value       = azurerm_public_ip.nat.ip_address
}

output "bastion_host_id" {
  value = var.enable_bastion ? azurerm_bastion_host.this[0].id : null
}

output "eso_client_id" {
  description = "Workload Identity client ID for External Secrets Operator's own controller ServiceAccount (<eso_namespace>/<eso_service_account_name>)"
  value       = azurerm_user_assigned_identity.eso.client_id
}

output "eso_key_vault_uri" {
  description = "Vault URI for the ClusterSecretStore's spec.provider.azurekv.vaultUrl"
  value       = azurerm_key_vault.eso.vault_uri
}

output "eso_key_vault_id" {
  value = azurerm_key_vault.eso.id
}

output "workflow_controller_artifacts_client_id" {
  description = "Client ID for the workflow-controller ServiceAccount's azure.workload.identity/client-id annotation - null unless enable_artifact_archiving is true. The pod also needs the azure.workload.identity/use: \"true\" label."
  value       = var.enable_artifact_archiving ? azurerm_user_assigned_identity.workflow_controller_artifacts[0].client_id : null
}

output "artifact_storage_account_name" {
  description = "Storage account Argo Workflows should archive logs/artifacts to - null unless enable_artifact_archiving is true"
  value       = var.enable_artifact_archiving ? azurerm_storage_account.argo_logs[0].name : null
}
