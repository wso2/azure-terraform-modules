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

  resource_group_name     = var.resource_group_name
  create_resource_group   = var.create_resource_group
  create_role_assignments = var.create_role_assignments
  location                = var.location
  tags                    = var.tags

  vnet_name          = var.vnet_name
  vnet_address_space = var.vnet_address_space

  aks_cluster_name = var.aks_cluster_name
  aks_dns_prefix   = var.aks_dns_prefix

  kubernetes_version = var.kubernetes_version
  service_cidr       = var.service_cidr
  dns_service_ip     = var.dns_service_ip

  aks_admin_username         = var.aks_admin_username
  aks_public_ssh_key_path    = var.aks_public_ssh_key_path
  aks_admin_group_object_ids = var.aks_admin_group_object_ids

  private_cluster_enabled         = var.private_cluster_enabled
  api_server_authorized_ip_ranges = var.api_server_authorized_ip_ranges

  log_analytics_workspace_id = var.log_analytics_workspace_id

  stage_subnet_address_prefix       = var.stage_subnet_address_prefix
  internal_lb_subnet_address_prefix = var.internal_lb_subnet_address_prefix
  stage_node_vm_size                = var.stage_node_vm_size
  stage_availability_zones          = var.stage_availability_zones
  stage_node_min_count              = var.stage_node_min_count
  stage_node_max_count              = var.stage_node_max_count

  prod_subnet_address_prefix = var.prod_subnet_address_prefix
  prod_node_vm_size          = var.prod_node_vm_size
  prod_availability_zones    = var.prod_availability_zones
  prod_node_min_count        = var.prod_node_min_count
  prod_node_max_count        = var.prod_node_max_count
  prod_node_taint_value      = var.prod_node_taint_value

  enable_bastion                       = var.enable_bastion
  bastion_subnet_address_prefix        = var.bastion_subnet_address_prefix
  bastion_allow_https_internet_inbound = var.bastion_allow_https_internet_inbound
  bastion_public_address_prefixes      = var.bastion_public_address_prefixes

  deploy_identities                = var.deploy_identities
  deploy_identity_role_assignments = var.deploy_identity_role_assignments

  enable_secrets_encryption = var.enable_secrets_encryption
  log_retention_in_days     = var.log_retention_in_days
  enable_vpc_flow_logs      = var.enable_vpc_flow_logs

  network_watcher_name                = var.network_watcher_name
  network_watcher_resource_group_name = var.network_watcher_resource_group_name

  enable_artifact_archiving = var.enable_artifact_archiving

  argo_namespace                           = var.argo_namespace
  workflow_controller_service_account_name = var.workflow_controller_service_account_name

  argo_logs_storage_account_name = var.argo_logs_storage_account_name
  flow_logs_storage_account_name = var.flow_logs_storage_account_name
}

# Bridges native-identity (AAD/Azure RBAC) auth into the kubernetes/helm
# providers below. cluster exposes no non-admin kube_config output on
# purpose, so this lookup is the only way to get the CA cert.
#
# No depends_on = [module.cluster]: that makes any unrelated new resource
# in the module mark this data source "known after apply", cascading into
# every kubernetes_namespace_v1/etc. failing plan-time refresh. The
# narrower name = module.cluster.aks_cluster_name reference below already
# creates the correct dependency.
data "azurerm_kubernetes_cluster" "this" {
  name                = module.cluster.aks_cluster_name
  resource_group_name = var.resource_group_name
}

# kubelogin's azurecli mode, same as environments/azure-dataplane/main.tf -
# "6dae42f8-4368-4678-94ff-3960e28e3630" is AKS's own well-known
# server-app-id for AAD token exchange, not a project-specific value.
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

  namespaces       = var.namespaces
  system_namespace = var.system_namespace

  argo_workflows_chart_version = var.argo_workflows_chart_version
  argo_events_chart_version    = var.argo_events_chart_version
  argo_helm_repo               = var.argo_helm_repo

  argo_workflows_values = var.argo_workflows_values
  argo_events_values    = var.argo_events_values

  install_argocd       = var.install_argocd
  argocd_namespace     = var.argocd_namespace
  argocd_chart_version = var.argocd_chart_version
  argocd_helm_repo     = var.argocd_helm_repo
  argocd_values        = var.argocd_values

  manifest_files = var.manifest_files

  install_external_secrets = var.install_external_secrets
  eso_chart_version        = var.eso_chart_version
  eso_helm_repo            = var.eso_helm_repo
  eso_namespace            = var.eso_namespace

  # Unlike the AWS composites, no cluster output is wired in here
  # automatically - see variables.tf's own header comment for why
  # federated_service_accounts stays a plain passthrough. A caller
  # composing through this module builds its value the same way
  # environments/azure-dataplane/main.tf does today, just referencing
  # this module's own deploy_identity_client_ids output (outputs.tf)
  # instead of module.cluster's directly.
  federated_service_accounts = var.federated_service_accounts

  kubectl_manifest_files  = var.kubectl_manifest_files
  rendered_manifest_files = var.rendered_manifest_files

  depends_on = [module.cluster]
}
