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
# Composite entrypoint wiring ./cluster to ./apps in one module call, as an
# ALTERNATIVE to calling the two submodules separately (see README.md).
#
# --------------------------------------------------------------------------------------

module "cluster" {
  source = "./cluster"

  resource_group_name                      = var.resource_group_name
  create_resource_group                    = var.create_resource_group
  create_role_assignments                  = var.create_role_assignments
  location                                 = var.location
  tags                                     = var.tags
  vnet_name                                = var.vnet_name
  vnet_address_space                       = var.vnet_address_space
  node_subnet_address_prefix               = var.node_subnet_address_prefix
  network_security_rules                   = var.network_security_rules
  aks_cluster_name                         = var.aks_cluster_name
  aks_dns_prefix                           = var.aks_dns_prefix
  kubernetes_version                       = var.kubernetes_version
  aks_admin_username                       = var.aks_admin_username
  aks_public_ssh_key_path                  = var.aks_public_ssh_key_path
  aks_admin_group_object_ids               = var.aks_admin_group_object_ids
  private_cluster_enabled                  = var.private_cluster_enabled
  api_server_authorized_ip_ranges          = var.api_server_authorized_ip_ranges
  service_cidr                             = var.service_cidr
  dns_service_ip                           = var.dns_service_ip
  log_analytics_workspace_id               = var.log_analytics_workspace_id
  node_vm_size                             = var.node_vm_size
  availability_zones                       = var.availability_zones
  node_min_count                           = var.node_min_count
  node_max_count                           = var.node_max_count
  enable_bastion                           = var.enable_bastion
  bastion_subnet_address_prefix            = var.bastion_subnet_address_prefix
  bastion_allow_https_internet_inbound     = var.bastion_allow_https_internet_inbound
  bastion_public_address_prefixes          = var.bastion_public_address_prefixes
  enable_secrets_encryption                = var.enable_secrets_encryption
  cluster_secrets_key_vault_name           = var.cluster_secrets_key_vault_name
  eso_namespace                            = var.eso_namespace
  eso_service_account_name                 = var.eso_service_account_name
  eso_key_vault_name                       = var.eso_key_vault_name
  log_retention_in_days                    = var.log_retention_in_days
  enable_vpc_flow_logs                     = var.enable_vpc_flow_logs
  network_watcher_name                     = var.network_watcher_name
  network_watcher_resource_group_name      = var.network_watcher_resource_group_name
  enable_artifact_archiving                = var.enable_artifact_archiving
  argo_namespace                           = var.argo_namespace
  workflow_controller_service_account_name = var.workflow_controller_service_account_name
  argo_logs_storage_account_name           = var.argo_logs_storage_account_name
  flow_logs_storage_account_name           = var.flow_logs_storage_account_name
}

# CA cert comes from this lookup - cluster exposes no non-admin kube_config.
# The name reference alone orders it after module.cluster.
data "azurerm_kubernetes_cluster" "this" {
  name                = module.cluster.aks_cluster_name
  resource_group_name = module.cluster.resource_group_name
}

# kubelogin azurecli mode; the server-id is AKS's fixed, well-known AAD
# server app ID, not a project-specific value.
provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.this.kube_config[0].host
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.this.kube_config[0].cluster_ca_certificate)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "kubelogin"
    args        = ["get-token", "--login", "azurecli", "--server-id", "6dae42f8-4368-4678-94ff-3960e28e3630"]
  }
}

provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.this.kube_config[0].host
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.this.kube_config[0].cluster_ca_certificate)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "kubelogin"
      args        = ["get-token", "--login", "azurecli", "--server-id", "6dae42f8-4368-4678-94ff-3960e28e3630"]
    }
  }
}

# lazy_load stops kubectl_manifest from using whatever kubeconfig context
# is ambient on the machine.
provider "kubectl" {
  host                   = data.azurerm_kubernetes_cluster.this.kube_config[0].host
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.this.kube_config[0].cluster_ca_certificate)
  load_config_file       = false
  lazy_load              = true

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "kubelogin"
    args        = ["get-token", "--login", "azurecli", "--server-id", "6dae42f8-4368-4678-94ff-3960e28e3630"]
  }
}

module "apps" {
  source = "./apps"

  namespace                      = var.namespace
  extra_namespaces               = var.extra_namespaces
  config_maps                    = var.config_maps
  tunnel_client_identities       = var.tunnel_client_identities
  argo_workflows_chart_version   = var.argo_workflows_chart_version
  argo_events_chart_version      = var.argo_events_chart_version
  nats_chart_version             = var.nats_chart_version
  argo_helm_repo                 = var.argo_helm_repo
  nats_helm_repo                 = var.nats_helm_repo
  argo_workflows_values          = var.argo_workflows_values
  argo_events_values             = var.argo_events_values
  nats_values                    = var.nats_values
  install_cert_manager           = var.install_cert_manager
  cert_manager_chart_version     = var.cert_manager_chart_version
  cert_manager_helm_repo         = var.cert_manager_helm_repo
  cert_manager_namespace         = var.cert_manager_namespace
  install_traefik                = var.install_traefik
  traefik_chart_version          = var.traefik_chart_version
  traefik_helm_repo              = var.traefik_helm_repo
  traefik_values                 = var.traefik_values
  traefik_namespace              = var.traefik_namespace
  nats_server_external_dns_names = var.nats_server_external_dns_names
  nats_client_identities         = var.nats_client_identities
  manifest_files                 = var.manifest_files
  install_external_secrets       = var.install_external_secrets
  eso_chart_version              = var.eso_chart_version
  eso_helm_repo                  = var.eso_helm_repo
  eso_namespace                  = var.eso_namespace
  kubectl_manifest_files         = var.kubectl_manifest_files

  # Only apps input auto-wired from cluster; other cluster outputs get
  # consumed inside the caller's own Helm values instead.
  eso_client_id = module.cluster.eso_client_id

  depends_on = [module.cluster]
}
