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

output "namespace_names" {
  description = "Names of every namespace this module created (var.namespaces plus var.argocd_namespace/var.system_namespace)"
  value       = [for ns in kubernetes_namespace_v1.namespace : ns.metadata[0].name]
}

output "system_namespace" {
  description = "Namespace the shared argo-server/workflow-controller/argo-events install runs in - same value as var.system_namespace, exposed so a caller doesn't have to keep it in sync separately"
  value       = var.system_namespace
}

output "argocd_namespace" {
  description = "Namespace ArgoCD was installed into - null unless var.install_argocd is true"
  value       = var.install_argocd ? var.argocd_namespace : null
}

output "eso_namespace" {
  description = "Namespace External Secrets Operator was installed into - null unless var.install_external_secrets is true"
  value       = var.install_external_secrets ? var.eso_namespace : null
}

output "federated_service_account_names" {
  description = "Kubernetes ServiceAccount name per var.federated_service_accounts entry - each one Workload-Identity-authenticated via its client_id annotation, e.g. for a ClusterSecretStore's serviceAccountRef"
  value       = { for k, sa in kubernetes_service_account_v1.federated : k => sa.metadata[0].name }
}
