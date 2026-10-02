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

output "resource_group_name" {
  value = module.cluster.resource_group_name
}

output "virtual_network_name" {
  value = module.cluster.virtual_network_name
}

output "nat_gateway_public_ip" {
  value = module.cluster.nat_gateway_public_ip
}

output "bastion_host_id" {
  value = module.cluster.bastion_host_id
}

output "eso_client_id" {
  description = "Workload Identity client ID for External Secrets Operator - already wired into module.apps; exposed here too for a caller's own Helm overrides."
  value       = module.cluster.eso_client_id
}

output "eso_key_vault_uri" {
  description = "Vault URI for the ClusterSecretStore's spec.provider.azurekv.vaultUrl"
  value       = module.cluster.eso_key_vault_uri
}

output "workflow_controller_artifacts_client_id" {
  value = module.cluster.workflow_controller_artifacts_client_id
}

output "artifact_storage_account_name" {
  value = module.cluster.artifact_storage_account_name
}

# --- From module.apps ---

output "nats_client_cert_pems" {
  description = "Per data-plane-identity NATS client cert PEM - copy out-of-band into that data plane's own terraform.tfvars, same pattern as tunnel_client_private_keys"
  value       = module.apps.nats_client_cert_pems
  sensitive   = true
}

output "nats_client_key_pems" {
  value     = module.apps.nats_client_key_pems
  sensitive = true
}

output "nats_client_ca_pems" {
  value     = module.apps.nats_client_ca_pems
  sensitive = true
}

output "tunnel_client_private_keys" {
  description = "OpenSSH-formatted private key per identity in tunnel_client_identities - copy into that data plane's own terraform.tfvars tunnel_client_private_key."
  value       = module.apps.tunnel_client_private_keys
  sensitive   = true
}
