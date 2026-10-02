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

# --- Passed to module.cluster ---

variable "resource_group_name" {
  type        = string
  description = "Resource group for the control plane (AKS, VNet, NAT Gateway, Key Vaults, Bastion)"
}

variable "create_resource_group" {
  type        = bool
  description = "Whether this module creates resource_group_name itself. Set to false to point at a resource group already managed elsewhere."
  default     = true
}

variable "create_role_assignments" {
  type        = bool
  description = "Whether to create the azurerm_role_assignment resources for ESO's Key Vault and the artifact storage account. Requires Owner or User Access Administrator at those scopes - a plain Contributor gets a 403. The KMS role assignments are gated by enable_secrets_encryption instead, since KMS can't work without them."
  default     = true
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to resources created by this module"
  default     = {}
}

variable "vnet_name" {
  type        = string
  description = "Name of the control plane's virtual network"
}

variable "vnet_address_space" {
  type        = string
  description = "Address space for the VNet, e.g. 10.4.0.0/16"
}

variable "node_subnet_address_prefix" {
  type        = string
  description = "CIDR for the AKS node subnet"
}

variable "network_security_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = optional(string, "*")
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = optional(string, "*")
  }))
  description = "Additional rules on the node subnet's NSG, beyond Azure's default rules"
  default     = []
}

variable "aks_cluster_name" {
  type        = string
  description = "Name of the AKS cluster. Also the prefix for every other resource name this module derives."
}

variable "aks_dns_prefix" {
  type        = string
  description = "DNS prefix for the AKS cluster"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}

variable "aks_admin_username" {
  type        = string
  description = "Admin username for AKS nodes"
  default     = "azureuser"
}

variable "aks_public_ssh_key_path" {
  type        = string
  description = "Path to the public SSH key file for AKS nodes"
}

variable "aks_admin_group_object_ids" {
  type        = list(string)
  description = "Entra ID group object IDs granted AKS cluster-admin via native Azure RBAC for Kubernetes. The identity running terraform apply must be in one of these to apply the apps module."
  default     = []
}

variable "private_cluster_enabled" {
  type        = bool
  description = "Whether the AKS API server has a private-only endpoint"
  default     = false
}

variable "api_server_authorized_ip_ranges" {
  type        = list(string)
  description = "Authorized IP ranges for the public API server endpoint, if not private"
  default     = []
}

variable "service_cidr" {
  type        = string
  description = "CIDR block for Kubernetes Services - must not overlap the VNet"
}

variable "dns_service_ip" {
  type        = string
  description = "DNS service IP, must be inside service_cidr"
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "Resource ID of an existing Log Analytics Workspace for AKS's oms_agent. Null disables Container Insights."
  default     = null
}

variable "node_vm_size" {
  type        = string
  description = "VM size for the shared node pool"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones for the shared node pool. NATS JetStream runs 3 replicas regardless, so use 3 zones for real node-level HA."
  default     = ["1", "2", "3"]

  validation {
    condition     = length(var.availability_zones) >= 2
    error_message = "At least 2 availability zones are required for basic node-level HA."
  }
}

variable "node_min_count" {
  type        = number
  description = "Minimum node count for the shared node pool's autoscaler"
  default     = 2
}

variable "node_max_count" {
  type        = number
  description = "Maximum node count for the shared node pool's autoscaler"
  default     = 4
}

variable "enable_bastion" {
  type        = bool
  description = "Whether to provision Azure Bastion for admin access"
  default     = true
}

variable "bastion_subnet_address_prefix" {
  type        = string
  description = "CIDR for the AzureBastionSubnet (/26 or larger) - required when enable_bastion is true"
  default     = null
}

variable "bastion_allow_https_internet_inbound" {
  type        = bool
  description = "Whether Bastion accepts inbound from the whole internet vs. only bastion_public_address_prefixes"
  default     = false
}

variable "bastion_public_address_prefixes" {
  type        = list(string)
  description = "Source CIDRs allowed to reach Bastion when bastion_allow_https_internet_inbound is false"
  default     = []
}

variable "enable_secrets_encryption" {
  type        = bool
  description = "Whether to create a Key Vault + key and enable AKS's KMS etcd encryption with it. Can only be turned on in a follow-up apply after the cluster exists, never the apply that first creates it."
  default     = false
}

variable "cluster_secrets_key_vault_name" {
  type        = string
  description = "Override for the KMS Key Vault's name (globally unique, <=24 chars). Null derives \"<aks_cluster_name>-kms\"."
  default     = null
}

variable "eso_namespace" {
  type        = string
  description = "Namespace External Secrets Operator runs in - scopes ESO's federated identity subject. Must match the apps module's eso_namespace."
  default     = "external-secrets"
}

variable "eso_key_vault_name" {
  type        = string
  description = "Override for ESO's Key Vault name (globally unique, <=24 chars). Null derives \"<aks_cluster_name>-secrets\"."
  default     = null
}

variable "log_retention_in_days" {
  type        = number
  description = "Retention for NSG Flow Logs and the artifact storage account's blob expiration, if enabled"
  default     = 90
}

variable "enable_vpc_flow_logs" {
  type        = bool
  description = "Whether to create NSG Flow Logs for the node subnet's NSG, published to a dedicated storage account"
  default     = false
}

variable "network_watcher_name" {
  type        = string
  description = "Name of the region's existing Network Watcher - required when enable_vpc_flow_logs is true"
  default     = null
}

variable "network_watcher_resource_group_name" {
  type        = string
  description = "Resource group containing network_watcher_name - required when enable_vpc_flow_logs is true"
  default     = null
}

variable "enable_artifact_archiving" {
  type        = bool
  description = "Whether to create a Storage Account + container + Workload Identity for Argo Workflows to archive logs/artifacts to. Wire the outputs into argo_workflows_values' artifactRepository config."
  default     = false
}

variable "argo_namespace" {
  type        = string
  description = "Namespace Argo Workflows runs in - only used to scope the workflow-controller's federated identity subject when enable_artifact_archiving is true"
  default     = "argo"
}

variable "workflow_controller_service_account_name" {
  type        = string
  description = "ServiceAccount name the argo-workflows Helm chart creates for workflow-controller - only used when enable_artifact_archiving is true"
  default     = "argo-workflows-workflow-controller"
}

variable "argo_logs_storage_account_name" {
  type        = string
  description = "Override for the argo_logs Storage Account name. Names are ForceNew, so pin an already-applied environment's live name here. Null for a fresh environment."
  default     = null
}

variable "flow_logs_storage_account_name" {
  type        = string
  description = "Same override as argo_logs_storage_account_name, for the flow_logs Storage Account"
  default     = null
}

# --- Passed to module.apps ---

variable "namespace" {
  type        = string
  description = "Kubernetes namespace for the control plane's Argo Workflows + Argo Events release"
  default     = "argo"
}

variable "extra_namespaces" {
  type        = list(string)
  description = "Additional namespaces to create beyond var.namespace (e.g. [\"oauth2-proxy\", \"gateway\"]), created before manifest_files/kubectl_manifest_files are applied."
  default     = []
}

variable "config_maps" {
  type = map(object({
    namespace = string
    data      = map(string)
  }))
  description = "ConfigMaps to create before manifest_files/kubectl_manifest_files are applied. Map key is the ConfigMap name; namespace must be var.namespace or one of extra_namespaces."
  default     = {}
}

variable "tunnel_client_identities" {
  type        = list(string)
  description = "One reverse-tunnel SSH keypair per data-plane identity (e.g. [\"aws\", \"azure\"]); private keys are exposed via tunnel_client_private_keys for out-of-band distribution. Default [] creates none."
  default     = []
}

variable "argo_workflows_chart_version" {
  type    = string
  default = null
}

variable "argo_events_chart_version" {
  type    = string
  default = null
}

variable "nats_chart_version" {
  type    = string
  default = null
}

variable "argo_helm_repo" {
  type    = string
  default = "https://argoproj.github.io/argo-helm"
}

variable "nats_helm_repo" {
  type    = string
  default = "https://nats-io.github.io/k8s/helm/charts/"
}

variable "argo_workflows_values" {
  type        = list(string)
  description = "Helm values overrides (YAML strings, later entries win) for argo-workflows. Should include workflow-controller replicas>=2 with leader election for HA."
  default     = []
}

variable "argo_events_values" {
  type        = list(string)
  description = "Helm values overrides (YAML strings, later entries win) for argo-events"
  default     = []
}

variable "nats_values" {
  type        = list(string)
  description = "Helm values overrides (YAML strings, later entries win) for the nats chart. Should set JetStream replicas=3 with anti-affinity across AZs and a PVC-backed store."
  default     = []
}

variable "install_cert_manager" {
  type        = bool
  description = "Install cert-manager and bootstrap a private client-CA for NATS mTLS client certs (this control plane's own, plus one per data plane). cert-manager renews before expiry automatically."
  default     = true
}

variable "cert_manager_chart_version" {
  type    = string
  default = null
}

variable "cert_manager_helm_repo" {
  type    = string
  default = "https://charts.jetstack.io"
}

variable "cert_manager_namespace" {
  type    = string
  default = "cert-manager"
}

variable "install_traefik" {
  type        = bool
  description = "Install the Traefik controller - required for gateway.yaml's Traefik-specific CRDs (IngressRoute, Middleware, ServersTransport)."
  default     = true
}

variable "traefik_chart_version" {
  type    = string
  default = null
}

variable "traefik_helm_repo" {
  type    = string
  default = "https://traefik.github.io/charts"
}

variable "traefik_values" {
  type        = list(string)
  description = "Helm values overrides for traefik. Must set providers.kubernetesCRD.allowExternalNameServices: true - gateway.yaml's backends are ExternalName Services, which Traefik refuses to route to by default."
  default     = []
}

variable "traefik_namespace" {
  type    = string
  default = "gateway"
}

variable "nats_server_external_dns_names" {
  type        = list(string)
  description = "Extra dnsNames for the nats-server-cert Certificate, beyond its two internal cluster-DNS names. Must include each data plane's own external NATS LoadBalancer hostname, or cross-cluster mTLS fails x509 SAN verification."
  default     = []
}

variable "nats_client_identities" {
  type        = list(string)
  description = "commonName for each data-plane NATS client certificate cert-manager issues, e.g. [\"azure-stage\", \"azure-prod\", \"aws-stage\", \"aws-prod\"]. Cert/key land in Secret \"nats-client-<entry>\", readable via nats_client_cert_pems/nats_client_key_pems for out-of-band distribution."
  default     = []
}

variable "manifest_files" {
  type = list(object({
    location     = optional(string)
    content      = optional(string)
    template_map = optional(map(string), {})
  }))
  description = "Additional Kubernetes manifests to apply - e.g. dispatch-namespace RBAC, the SSO gateway, Ingress/Service for the Load Balancer. Set content directly to pass already-fetched text instead of a location file path."
  default     = []
}

variable "install_external_secrets" {
  type        = bool
  description = "Install External Secrets Operator, used to sync the oauth2-proxy cookie-signing secret and SSO client secret from the cluster module's ESO Key Vault."
  default     = true
}

variable "eso_chart_version" {
  type    = string
  default = null
}

variable "eso_helm_repo" {
  type    = string
  default = "https://charts.external-secrets.io"
}

variable "kubectl_manifest_files" {
  type = list(object({
    location     = optional(string)
    content      = optional(string)
    template_map = optional(map(string), {})
    namespace    = optional(string)
  }))
  description = "Manifests applied via the kubectl provider instead of kubernetes_manifest - required for anything backed by a CRD installed in this same apply (e.g. ESO's ClusterSecretStore/ExternalSecret). namespace, if set, overrides each object's own metadata.namespace."
  default     = []
}
