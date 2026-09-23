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
# Raw azurerm resource blocks. Stage is the cluster's default node pool +
# its own subnet; prod is a separate subnet and a separate, tainted node
# pool. Cluster admin access is native Azure RBAC plus an optional
# Bastion.
#
# --------------------------------------------------------------------------------------

# Azure resources can't exist without a resource group first.
# create_resource_group defaults to true; set false to point
# resource_group_name at one already managed elsewhere.
resource "azurerm_resource_group" "this" {
  count    = var.create_resource_group ? 1 : 0
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

locals {
  resource_group_name = var.create_resource_group ? azurerm_resource_group.this[0].name : var.resource_group_name

  # Storage account names must be <=24 chars, lowercase alphanumeric only;
  # reserve room for the full suffix so it isn't truncated mid-word.
  cluster_name_sanitized         = lower(replace(var.aks_cluster_name, "-", ""))
  flow_logs_storage_account_name = coalesce(var.flow_logs_storage_account_name, "${substr(local.cluster_name_sanitized, 0, 24 - length("flowlogs"))}flowlogs")
  argo_logs_storage_account_name = coalesce(var.argo_logs_storage_account_name, "${substr(local.cluster_name_sanitized, 0, 24 - length("argologs"))}argologs")
}

resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  address_space       = [var.vnet_address_space]
  location            = var.location
  resource_group_name = local.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet" "stage" {
  name                 = "${var.aks_cluster_name}-stage-snet"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.stage_subnet_address_prefix]
}

resource "azurerm_subnet" "prod" {
  name                 = "${var.aks_cluster_name}-prod-snet"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.prod_subnet_address_prefix]
}

resource "azurerm_subnet" "ilb" {
  name                 = "${var.aks_cluster_name}-ilb-snet"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.internal_lb_subnet_address_prefix]
}

# --- Per-tier NSGs. Prod's own NSG denies inbound from the stage subnet -
#     the real network isolation boundary underneath the taint. ---

resource "azurerm_network_security_group" "stage" {
  name                = "${var.aks_cluster_name}-stage-nsg"
  location            = var.location
  resource_group_name = local.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "stage" {
  subnet_id                 = azurerm_subnet.stage.id
  network_security_group_id = azurerm_network_security_group.stage.id
}

resource "azurerm_network_security_group" "prod" {
  name                = "${var.aks_cluster_name}-prod-nsg"
  location            = var.location
  resource_group_name = local.resource_group_name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "deny_stage_inbound_to_prod" {
  name                        = "DenyStageSubnetInbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = var.stage_subnet_address_prefix
  destination_address_prefix  = "*"
  resource_group_name         = local.resource_group_name
  network_security_group_name = azurerm_network_security_group.prod.name
}

resource "azurerm_subnet_network_security_group_association" "prod" {
  subnet_id                 = azurerm_subnet.prod.id
  network_security_group_id = azurerm_network_security_group.prod.id
}

# --- Per-tier NAT Gateways (own outbound IP each) ---

resource "azurerm_public_ip" "stage_nat" {
  name                = "${var.aks_cluster_name}-stage-nat-pip"
  location            = var.location
  resource_group_name = local.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_nat_gateway" "stage" {
  name                = "${var.aks_cluster_name}-stage-nat"
  location            = var.location
  resource_group_name = local.resource_group_name
  sku_name            = "Standard"
  tags                = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "stage" {
  nat_gateway_id       = azurerm_nat_gateway.stage.id
  public_ip_address_id = azurerm_public_ip.stage_nat.id
}

resource "azurerm_subnet_nat_gateway_association" "stage" {
  subnet_id      = azurerm_subnet.stage.id
  nat_gateway_id = azurerm_nat_gateway.stage.id
}

resource "azurerm_public_ip" "prod_nat" {
  name                = "${var.aks_cluster_name}-prod-nat-pip"
  location            = var.location
  resource_group_name = local.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_nat_gateway" "prod" {
  name                = "${var.aks_cluster_name}-prod-nat"
  location            = var.location
  resource_group_name = local.resource_group_name
  sku_name            = "Standard"
  tags                = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "prod" {
  nat_gateway_id       = azurerm_nat_gateway.prod.id
  public_ip_address_id = azurerm_public_ip.prod_nat.id
}

resource "azurerm_subnet_nat_gateway_association" "prod" {
  subnet_id      = azurerm_subnet.prod.id
  nat_gateway_id = azurerm_nat_gateway.prod.id
}

# --- AKS cluster: stage is the default node pool, prod is a separate,
#     tainted node pool ---

resource "azurerm_kubernetes_cluster" "this" {
  name                = var.aks_cluster_name
  location            = var.location
  resource_group_name = local.resource_group_name
  dns_prefix          = var.aks_dns_prefix
  kubernetes_version  = var.kubernetes_version

  private_cluster_enabled = var.private_cluster_enabled

  api_server_access_profile {
    authorized_ip_ranges = var.api_server_authorized_ip_ranges
  }

  # Required by azurerm >= 5.x's node_provisioning_profile schema addition
  # (tied to AKS Node Autoprovisioning / Karpenter integration) - "Manual"
  # since node pools here are explicitly, individually managed below, not
  # auto-provisioned by AKS itself.
  node_provisioning_profile {
    mode = "Manual"
  }

  default_node_pool {
    name                         = "stage"
    vm_size                      = var.stage_node_vm_size
    vnet_subnet_id               = azurerm_subnet.stage.id
    zones                        = [for z in var.stage_availability_zones : tostring(z)]
    auto_scaling_enabled         = true
    min_count                    = var.stage_node_min_count
    max_count                    = var.stage_node_max_count
    os_disk_size_gb              = 128
    max_pods                     = 110
    only_critical_addons_enabled = false

    # Explicit, not left as optional/computed - otherwise Terraform plans
    # to null it out every run, forcing an in-place update that makes
    # kube_config (and the kubernetes provider's config) unknown at plan
    # time, breaking every kubernetes_namespace_v1 refresh.
    upgrade_settings {
      max_surge                     = "10%"
      drain_timeout_in_minutes      = 0
      node_soak_duration_in_minutes = 0
    }
  }

  identity {
    type = "SystemAssigned"
  }

  linux_profile {
    admin_username = var.aks_admin_username
    ssh_key {
      key_data = file(var.aks_public_ssh_key_path)
    }
  }

  network_profile {
    network_plugin = "azure"
    service_cidr   = var.service_cidr
    dns_service_ip = var.dns_service_ip
  }

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  azure_active_directory_role_based_access_control {
    azure_rbac_enabled     = true
    admin_group_object_ids = var.aks_admin_group_object_ids
  }

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  # AKS's control-plane identity needs Key Vault access to use this key
  # (azurerm_role_assignment.kms below), which can't exist before the
  # cluster does - enable_secrets_encryption must be a follow-up apply,
  # not the one that first creates the cluster.
  dynamic "key_management_service" {
    for_each = var.enable_secrets_encryption ? [1] : []
    content {
      key_vault_key_id = azurerm_key_vault_key.cluster_secrets[0].id
    }
  }

  tags = var.tags

  depends_on = [
    azurerm_subnet_nat_gateway_association.stage,
    azurerm_subnet_network_security_group_association.stage,
  ]
}

resource "azurerm_kubernetes_cluster_node_pool" "prod" {
  name                  = "prod"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vm_size               = var.prod_node_vm_size
  vnet_subnet_id        = azurerm_subnet.prod.id
  zones                 = var.prod_availability_zones
  auto_scaling_enabled  = true
  min_count             = var.prod_node_min_count
  max_count             = var.prod_node_max_count
  os_disk_size_gb       = 128
  max_pods              = 110
  mode                  = "User"
  node_taints           = ["env=${var.prod_node_taint_value}:NoSchedule"]
  # Taint alone only keeps other workloads OFF this pool - anything that
  # self-selects onto it (nodeSelector: env=prod) also needs the matching
  # label, or it stays Pending even with the right toleration.
  node_labels = {
    env = var.prod_node_taint_value
  }

  # See default_node_pool's own upgrade_settings comment above - same
  # provider-drift fix, needed here too since this pool has its own
  # independent upgrade_settings block.
  upgrade_settings {
    max_surge                     = "10%"
    drain_timeout_in_minutes      = 0
    node_soak_duration_in_minutes = 0
  }

  tags = var.tags

  depends_on = [
    azurerm_subnet_nat_gateway_association.prod,
    azurerm_subnet_network_security_group_association.prod,
  ]
}

# --- etcd secrets encryption (AKS's KMS feature) - see the
#     key_management_service block above for the two-apply caveat ---

data "azurerm_client_config" "current" {
  count = var.enable_secrets_encryption ? 1 : 0
}

resource "azurerm_key_vault" "cluster_secrets" {
  count = var.enable_secrets_encryption ? 1 : 0

  # Key Vault names must be <=24 chars.
  name                       = substr("${var.aks_cluster_name}-kv", 0, 24)
  location                   = var.location
  resource_group_name        = local.resource_group_name
  tenant_id                  = data.azurerm_client_config.current[0].tenant_id
  sku_name                   = "standard"
  rbac_authorization_enabled = true
  purge_protection_enabled   = true
  soft_delete_retention_days = 90
  tags                       = var.tags
}

resource "azurerm_key_vault_key" "cluster_secrets" {
  count = var.enable_secrets_encryption ? 1 : 0

  name         = "${var.aks_cluster_name}-etcd-key"
  key_vault_id = azurerm_key_vault.cluster_secrets[0].id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt", "unwrapKey", "wrapKey"]

  depends_on = [azurerm_role_assignment.cluster_secrets_admin]
}

# The identity running `terraform apply` needs its own grant to create
# the key above - Key Vault's RBAC model requires this even for the
# account that just created the vault.
resource "azurerm_role_assignment" "cluster_secrets_admin" {
  count = var.enable_secrets_encryption ? 1 : 0

  scope                = azurerm_key_vault.cluster_secrets[0].id
  role_definition_name = "Key Vault Crypto Officer"
  principal_id         = data.azurerm_client_config.current[0].object_id
}

# The cluster's own control-plane identity - see the key_management_service
# comment above for why this can't be part of the same apply that creates
# the cluster.
resource "azurerm_role_assignment" "kms" {
  count = var.enable_secrets_encryption ? 1 : 0

  scope                = azurerm_key_vault.cluster_secrets[0].id
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = azurerm_kubernetes_cluster.this.identity[0].principal_id
}

# --- NSG Flow Logs - duplicates what a VPC-Flow-Log-equivalent module
#     would do, kept opt-in for the same reason the AWS side is. Requires
#     Network Watcher already enabled for this region (Azure's default,
#     but org policy can disable it - hence caller-supplied, not assumed). ---

resource "azurerm_storage_account" "flow_logs" {
  count = var.enable_vpc_flow_logs ? 1 : 0

  name                     = local.flow_logs_storage_account_name
  resource_group_name      = local.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}

resource "azurerm_network_watcher_flow_log" "stage" {
  count = var.enable_vpc_flow_logs ? 1 : 0

  name                 = "${var.aks_cluster_name}-stage-flow-log"
  network_watcher_name = var.network_watcher_name
  resource_group_name  = var.network_watcher_resource_group_name
  target_resource_id   = azurerm_network_security_group.stage.id
  storage_account_id   = azurerm_storage_account.flow_logs[0].id
  enabled              = true
  retention_policy {
    enabled = true
    days    = var.log_retention_in_days
  }
}

resource "azurerm_network_watcher_flow_log" "prod" {
  count = var.enable_vpc_flow_logs ? 1 : 0

  name                 = "${var.aks_cluster_name}-prod-flow-log"
  network_watcher_name = var.network_watcher_name
  resource_group_name  = var.network_watcher_resource_group_name
  target_resource_id   = azurerm_network_security_group.prod.id
  storage_account_id   = azurerm_storage_account.flow_logs[0].id
  enabled              = true
  retention_policy {
    enabled = true
    days    = var.log_retention_in_days
  }
}

# --- Argo's own artifact repository - see Argo-EKS-DataPlane's identical
#     rationale. Workload Identity Federation instead of IRSA, otherwise
#     the same shape. ---

resource "azurerm_storage_account" "argo_logs" {
  count = var.enable_artifact_archiving ? 1 : 0

  name                     = local.argo_logs_storage_account_name
  resource_group_name      = local.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}

resource "azurerm_storage_container" "argo_logs" {
  count = var.enable_artifact_archiving ? 1 : 0

  name                  = "argo-logs"
  storage_account_id    = azurerm_storage_account.argo_logs[0].id
  container_access_type = "private"
}

resource "azurerm_storage_management_policy" "argo_logs" {
  count = var.enable_artifact_archiving ? 1 : 0

  storage_account_id = azurerm_storage_account.argo_logs[0].id

  rule {
    name    = "expire-after-retention"
    enabled = true
    filters {
      blob_types = ["blockBlob"]
    }
    actions {
      base_blob {
        delete_after_days_since_modification_greater_than = var.log_retention_in_days
      }
    }
  }
}

resource "azurerm_user_assigned_identity" "workflow_controller_artifacts" {
  count = var.enable_artifact_archiving ? 1 : 0

  name                = "${var.aks_cluster_name}-workflow-artifacts"
  location            = var.location
  resource_group_name = local.resource_group_name
  tags                = var.tags
}

resource "azurerm_federated_identity_credential" "workflow_controller_artifacts" {
  count = var.enable_artifact_archiving ? 1 : 0

  name                      = "${var.aks_cluster_name}-workflow-artifacts"
  user_assigned_identity_id = azurerm_user_assigned_identity.workflow_controller_artifacts[0].id
  audience                  = ["api://AzureADTokenExchange"]
  issuer                    = azurerm_kubernetes_cluster.this.oidc_issuer_url
  subject                   = "system:serviceaccount:${var.argo_namespace}:${var.workflow_controller_service_account_name}"
}

resource "azurerm_role_assignment" "workflow_controller_artifacts" {
  count = var.enable_artifact_archiving && var.create_role_assignments ? 1 : 0

  scope                = azurerm_storage_account.argo_logs[0].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.workflow_controller_artifacts[0].principal_id
}

# --- Bastion: native-identity admin access path (login-flow decision) ---

resource "azurerm_subnet" "bastion" {
  count = var.enable_bastion ? 1 : 0

  name                 = "AzureBastionSubnet"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.bastion_subnet_address_prefix]
}

resource "azurerm_public_ip" "bastion" {
  count = var.enable_bastion ? 1 : 0

  name                = "${var.aks_cluster_name}-bastion-pip"
  location            = var.location
  resource_group_name = local.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_network_security_group" "bastion" {
  count = var.enable_bastion ? 1 : 0

  name                = "${var.aks_cluster_name}-bastion-nsg"
  location            = var.location
  resource_group_name = local.resource_group_name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "bastion_allow_https_inbound" {
  count = var.enable_bastion ? 1 : 0

  name                        = "AllowHttpsInBound"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = var.bastion_allow_https_internet_inbound ? "Internet" : null
  source_address_prefixes     = var.bastion_allow_https_internet_inbound ? null : var.bastion_public_address_prefixes
  destination_address_prefix  = "*"
  resource_group_name         = local.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion[0].name
}

resource "azurerm_network_security_rule" "bastion_allow_gateway_manager_inbound" {
  count = var.enable_bastion ? 1 : 0

  name                        = "AllowGatewayManagerInBound"
  priority                    = 210
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "GatewayManager"
  destination_address_prefix  = "*"
  resource_group_name         = local.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion[0].name
}

resource "azurerm_network_security_rule" "bastion_allow_azure_lb_inbound" {
  count = var.enable_bastion ? 1 : 0

  name                        = "AllowAzureLoadBalancerInBound"
  priority                    = 220
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "AzureLoadBalancer"
  destination_address_prefix  = "*"
  resource_group_name         = local.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion[0].name
}

resource "azurerm_network_security_rule" "bastion_allow_host_comm_inbound" {
  count = var.enable_bastion ? 1 : 0

  name                        = "AllowBastionHostCommunication"
  priority                    = 230
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["8080", "5701"]
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = local.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion[0].name
}

resource "azurerm_network_security_rule" "bastion_allow_ssh_rdp_outbound" {
  count = var.enable_bastion ? 1 : 0

  name                        = "AllowSshRdpOutBound"
  priority                    = 200
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_ranges     = ["3389", "22"]
  source_address_prefix       = "*"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = local.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion[0].name
}

resource "azurerm_network_security_rule" "bastion_allow_azure_cloud_outbound" {
  count = var.enable_bastion ? 1 : 0

  name                        = "AllowAzureCloudOutBound"
  priority                    = 210
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "AzureCloud"
  resource_group_name         = local.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion[0].name
}

resource "azurerm_network_security_rule" "bastion_allow_comm_outbound" {
  count = var.enable_bastion ? 1 : 0

  name                        = "AllowBastionCommunication"
  priority                    = 220
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["8080", "5701"]
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = local.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion[0].name
}

resource "azurerm_network_security_rule" "bastion_allow_get_session_outbound" {
  count = var.enable_bastion ? 1 : 0

  name                        = "AllowGetSessionInformation"
  priority                    = 230
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "Internet"
  resource_group_name         = local.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion[0].name
}

resource "azurerm_subnet_network_security_group_association" "bastion" {
  count = var.enable_bastion ? 1 : 0

  subnet_id                 = azurerm_subnet.bastion[0].id
  network_security_group_id = azurerm_network_security_group.bastion[0].id
}

resource "azurerm_bastion_host" "this" {
  count = var.enable_bastion ? 1 : 0

  name                = "${var.aks_cluster_name}-bastion"
  location            = var.location
  resource_group_name = local.resource_group_name
  sku                 = "Standard"
  tunneling_enabled   = true
  ip_connect_enabled  = true
  tags                = var.tags

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion[0].id
    public_ip_address_id = azurerm_public_ip.bastion[0].id
  }

  depends_on = [azurerm_subnet_network_security_group_association.bastion]
}

# Per-env Workload Identity Federation for pipeline pods. Trust is scoped
# to exactly one (namespace, ServiceAccount) subject per entry.

resource "azurerm_user_assigned_identity" "deploy_identity" {
  for_each = var.deploy_identities

  name                = "${var.aks_cluster_name}-deploy-${each.key}"
  location            = var.location
  resource_group_name = local.resource_group_name
  tags                = var.tags
}

resource "azurerm_federated_identity_credential" "deploy_identity" {
  for_each = var.deploy_identities

  name                      = "${var.aks_cluster_name}-deploy-${each.key}"
  user_assigned_identity_id = azurerm_user_assigned_identity.deploy_identity[each.key].id
  audience                  = ["api://AzureADTokenExchange"]
  issuer                    = azurerm_kubernetes_cluster.this.oidc_issuer_url
  subject                   = "system:serviceaccount:${each.value.namespace}:${each.value.service_account_name}"
}

resource "azurerm_role_assignment" "deploy_identity" {
  for_each = var.create_role_assignments ? { for idx, ra in var.deploy_identity_role_assignments : idx => ra } : {}

  principal_id         = azurerm_user_assigned_identity.deploy_identity[each.value.identity_key].principal_id
  role_definition_name = each.value.role_definition_name
  scope                = each.value.scope
}
