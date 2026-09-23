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
#
# Outputs a caller composing through this module actually needs
# downstream, not every internal cluster/apps output.
#
# --------------------------------------------------------------------------------------

# --- From module.cluster ---

output "aks_cluster_name" {
  value = module.cluster.aks_cluster_name
}

output "kubernetes_cluster_fqdn" {
  value = module.cluster.kubernetes_cluster_fqdn
}

output "aks_oidc_issuer_url" {
  value = module.cluster.aks_oidc_issuer_url
}

output "virtual_network_name" {
  value = module.cluster.virtual_network_name
}

output "bastion_host_id" {
  value = module.cluster.bastion_host_id
}

output "deploy_identity_client_ids" {
  description = "Client ID per deploy_identities entry - build var.federated_service_accounts entries from this, same pattern environments/azure-dataplane/main.tf uses against module.cluster directly"
  value       = module.cluster.deploy_identity_client_ids
}

output "workflow_controller_artifacts_client_id" {
  value = module.cluster.workflow_controller_artifacts_client_id
}

output "artifact_storage_account_name" {
  value = module.cluster.artifact_storage_account_name
}

# --- From module.apps ---

output "namespace_names" {
  value = module.apps.namespace_names
}

output "system_namespace" {
  value = module.apps.system_namespace
}

output "argocd_namespace" {
  value = module.apps.argocd_namespace
}

output "eso_namespace" {
  value = module.apps.eso_namespace
}

output "federated_service_account_names" {
  value = module.apps.federated_service_account_names
}
