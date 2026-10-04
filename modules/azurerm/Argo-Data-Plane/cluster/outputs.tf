# -------------------------------------------------------------------------------------
#
# Copyright (c) 2026, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
#
# WSO2 LLC. licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the
# specific language governing permissions and limitations
# under the License.
#
# --------------------------------------------------------------------------------------

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks_cluster.name
}

output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.aks_cluster.id
}

output "kubernetes_cluster_fqdn" {
  value = azurerm_kubernetes_cluster.aks_cluster.fqdn
}

output "kubernetes_cluster_private_fqdn" {
  value = azurerm_kubernetes_cluster.aks_cluster.private_fqdn
}

output "aks_oidc_issuer_url" {
  value = azurerm_kubernetes_cluster.aks_cluster.oidc_issuer_url
}

output "virtual_network_name" {
  value = azurerm_virtual_network.virtual_network.name
}

output "stage_subnet_id" {
  value = azurerm_subnet.stage.id
}

output "prod_subnet_id" {
  value = azurerm_subnet.prod.id
}

output "bastion_host_id" {
  value = var.enable_bastion ? azurerm_bastion_host.bastion_host[0].id : null
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
