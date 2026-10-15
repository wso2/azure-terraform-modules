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

resource "azurerm_resource_group" "resource_group" {
  count    = var.create_resource_group ? 1 : 0
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "virtual_network" {
  name                = var.vnet_name
  address_space       = [var.vnet_address_space]
  location            = var.location
  resource_group_name = local.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet" "tier" {
  for_each = local.tiers

  name                 = "${var.aks_cluster_name}-${each.key}-snet"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = [each.value.subnet_address_prefix]
}

resource "azurerm_subnet" "ilb" {
  name                 = "${var.aks_cluster_name}-ilb-snet"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = [var.internal_lb_subnet_address_prefix]
}

# Outside both tiers' subnets and NSG rules on purpose - see
# system_subnet_address_prefix's own description.
resource "azurerm_subnet" "system" {
  name                 = "${var.aks_cluster_name}-system-snet"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = [var.system_subnet_address_prefix]
}

resource "azurerm_network_security_group" "system" {
  name                = "${var.aks_cluster_name}-system-nsg"
  location            = var.location
  resource_group_name = local.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "system" {
  subnet_id                 = azurerm_subnet.system.id
  network_security_group_id = azurerm_network_security_group.system.id
}

resource "azurerm_public_ip" "system_nat" {
  name                = "${var.aks_cluster_name}-system-nat-pip"
  location            = var.location
  resource_group_name = local.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_nat_gateway" "system_nat" {
  name                = "${var.aks_cluster_name}-system-nat"
  location            = var.location
  resource_group_name = local.resource_group_name
  sku_name            = "Standard"
  tags                = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "system_nat" {
  nat_gateway_id       = azurerm_nat_gateway.system_nat.id
  public_ip_address_id = azurerm_public_ip.system_nat.id
}

resource "azurerm_subnet_nat_gateway_association" "system" {
  subnet_id      = azurerm_subnet.system.id
  nat_gateway_id = azurerm_nat_gateway.system_nat.id
}

# --- Per-tier NSGs; prod denies inbound from the stage subnet ---
#
# Under overlay networking this rule covers traffic that leaves a stage
# node with the node's own address: host-network pods, and stage pods
# calling a prod node IP or NodePort (SNAT to the node). Pod-to-pod traffic
# keeps its pod_cidr source address, and pod_cidr is carved per node, not
# per tier, so no subnet rule can tell a stage pod from a prod pod. That
# half is enforced by NetworkPolicy (enable_network_policy here, and
# namespace_tiers in the apps module).

resource "azurerm_network_security_group" "tier" {
  for_each = local.tiers

  name                = "${var.aks_cluster_name}-${each.key}-nsg"
  location            = var.location
  resource_group_name = local.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "tier" {
  for_each = local.tiers

  subnet_id                 = azurerm_subnet.tier[each.key].id
  network_security_group_id = azurerm_network_security_group.tier[each.key].id
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
  network_security_group_name = azurerm_network_security_group.tier["prod"].name
}

# --- Per-tier NAT Gateways (own outbound IP each) ---

resource "azurerm_public_ip" "nat" {
  for_each = local.tiers

  name                = "${var.aks_cluster_name}-${each.key}-nat-pip"
  location            = var.location
  resource_group_name = local.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_nat_gateway" "nat_gateway" {
  for_each = local.tiers

  name                = "${var.aks_cluster_name}-${each.key}-nat"
  location            = var.location
  resource_group_name = local.resource_group_name
  sku_name            = "Standard"
  tags                = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "nat_gateway_public_ip_association" {
  for_each = local.tiers

  nat_gateway_id       = azurerm_nat_gateway.nat_gateway[each.key].id
  public_ip_address_id = azurerm_public_ip.nat[each.key].id
}

resource "azurerm_subnet_nat_gateway_association" "tier" {
  for_each = local.tiers

  subnet_id      = azurerm_subnet.tier[each.key].id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway[each.key].id
}

# --- AKS cluster ---

# AKS KMS doesn't work with a system-assigned identity: the Key Vault grant
# has to exist before the cluster does.
resource "azurerm_user_assigned_identity" "cluster" {
  name                = "${var.aks_cluster_name}-identity"
  location            = var.location
  resource_group_name = local.resource_group_name
  tags                = var.tags
}

# Required because the VNet lives outside the AKS-managed node resource group.
resource "azurerm_role_assignment" "cluster_network" {
  count = var.create_role_assignments ? 1 : 0

  scope                = azurerm_virtual_network.virtual_network.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.cluster.principal_id
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.aks_cluster_name
  location            = var.location
  resource_group_name = local.resource_group_name
  dns_prefix          = var.aks_dns_prefix
  kubernetes_version  = var.kubernetes_version

  private_cluster_enabled = var.private_cluster_enabled
  local_account_disabled  = var.local_account_disabled

  # Azure doesn't return this block for a private cluster, so declaring it
  # unconditionally shows a diff on every plan.
  dynamic "api_server_access_profile" {
    for_each = var.private_cluster_enabled ? [] : [1]
    content {
      authorized_ip_ranges = var.api_server_authorized_ip_ranges
    }
  }

  # Needs azurerm >= 4.57 (see versions.tf). Explicit, not left at the
  # provider default, because node pools here are managed by this config,
  # not AKS auto-provisioning.
  node_provisioning_profile {
    mode = "Manual"
  }

  # The AKS-required initial pool: dedicated to system components, not a
  # workload tier. only_critical_addons_enabled taints it
  # CriticalAddonsOnly=true:NoSchedule - AKS's own add-ons (coredns,
  # metrics-server, konnectivity-agent) tolerate that taint by default,
  # so they land here instead of on stage, where the prod NSG's
  # deny-from-stage rule would otherwise cut them off from prod nodes.
  # Stage and prod are both separate azurerm_kubernetes_cluster_node_pool
  # resources below.
  default_node_pool {
    name                         = "system"
    vm_size                      = var.system_node_vm_size
    vnet_subnet_id               = azurerm_subnet.system.id
    zones                        = [for z in var.system_availability_zones : tostring(z)]
    auto_scaling_enabled         = true
    min_count                    = var.system_node_min_count
    max_count                    = var.system_node_max_count
    os_disk_size_gb              = 128
    max_pods                     = 30
    only_critical_addons_enabled = true

    # Explicit: left computed, it causes a perpetual diff that makes
    # kube_config unknown at plan time.
    upgrade_settings {
      max_surge                     = "10%"
      drain_timeout_in_minutes      = 0
      node_soak_duration_in_minutes = 0
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.cluster.id]
  }

  linux_profile {
    admin_username = var.aks_admin_username
    ssh_key {
      key_data = var.aks_public_ssh_key
    }
  }

  # Overlay mode: pod IPs come from pod_cidr and are never routed on the
  # VNet, so they don't consume subnet space. Without this, each tier's
  # subnet needs one IP per pod slot across every node in that tier
  # (max_pods x node count), which exhausts a modestly-sized subnet fast.
  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_data_plane  = var.enable_network_policy ? "cilium" : "azure"
    network_policy      = var.enable_network_policy ? "cilium" : null
    pod_cidr            = var.pod_cidr
    service_cidr        = var.service_cidr
    dns_service_ip      = var.dns_service_ip
  }

  dynamic "oms_agent" {
    for_each = var.log_analytics_workspace_id != null ? [1] : []
    content {
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  azure_active_directory_role_based_access_control {
    azure_rbac_enabled     = true
    admin_group_object_ids = var.aks_admin_group_object_ids
  }

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  dynamic "key_management_service" {
    for_each = var.enable_secrets_encryption ? [1] : []
    content {
      key_vault_key_id = azurerm_key_vault_key.cluster_secrets[0].id
    }
  }

  tags = var.tags

  depends_on = [
    azurerm_subnet_nat_gateway_association.tier,
    azurerm_subnet_network_security_group_association.tier,
    azurerm_subnet_nat_gateway_association.system,
    azurerm_subnet_network_security_group_association.system,
    azurerm_role_assignment.cluster_network,
    azurerm_role_assignment.kms,
  ]
}

resource "azurerm_kubernetes_cluster_node_pool" "stage" {
  name                  = "stage"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
  vm_size               = var.stage_node_vm_size
  vnet_subnet_id        = azurerm_subnet.tier["stage"].id
  zones                 = [for z in var.stage_availability_zones : tostring(z)]
  auto_scaling_enabled  = true
  min_count             = var.stage_node_min_count
  max_count             = var.stage_node_max_count
  os_disk_size_gb       = 128
  max_pods              = 110
  mode                  = "User"

  upgrade_settings {
    max_surge                     = "10%"
    drain_timeout_in_minutes      = 0
    node_soak_duration_in_minutes = 0
  }

  tags = var.tags

  depends_on = [
    azurerm_subnet_nat_gateway_association.tier,
    azurerm_subnet_network_security_group_association.tier,
  ]
}

resource "azurerm_kubernetes_cluster_node_pool" "prod" {
  name                  = "prod"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
  vm_size               = var.prod_node_vm_size
  vnet_subnet_id        = azurerm_subnet.tier["prod"].id
  zones                 = var.prod_availability_zones
  auto_scaling_enabled  = true
  min_count             = var.prod_node_min_count
  max_count             = var.prod_node_max_count
  os_disk_size_gb       = 128
  max_pods              = 110
  mode                  = "User"
  node_taints           = ["env=${var.prod_node_taint_value}:NoSchedule"]
  # Pods selecting env=prod need this label as well as the toleration.
  node_labels = {
    env = var.prod_node_taint_value
  }

  upgrade_settings {
    max_surge                     = "10%"
    drain_timeout_in_minutes      = 0
    node_soak_duration_in_minutes = 0
  }

  tags = var.tags

  depends_on = [
    azurerm_subnet_nat_gateway_association.tier,
    azurerm_subnet_network_security_group_association.tier,
  ]
}

# --- etcd secrets encryption (KMS) ---

data "azurerm_client_config" "current" {
  count = var.enable_secrets_encryption ? 1 : 0
}

resource "azurerm_key_vault" "cluster_secrets" {
  count = var.enable_secrets_encryption ? 1 : 0

  name                       = local.cluster_secrets_key_vault_name
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

# Key Vault RBAC requires an explicit grant even for the vault's creator.
resource "azurerm_role_assignment" "cluster_secrets_admin" {
  count = var.enable_secrets_encryption ? 1 : 0

  scope                = azurerm_key_vault.cluster_secrets[0].id
  role_definition_name = "Key Vault Crypto Officer"
  principal_id         = data.azurerm_client_config.current[0].object_id
}

resource "azurerm_role_assignment" "kms" {
  count = var.enable_secrets_encryption ? 1 : 0

  scope                = azurerm_key_vault.cluster_secrets[0].id
  role_definition_name = "Key Vault Crypto User"
  principal_id         = azurerm_user_assigned_identity.cluster.principal_id
}

# --- VNet flow logs (opt-in, needs an existing Network Watcher) ---

resource "azurerm_storage_account" "flow_logs" {
  count = var.enable_vpc_flow_logs ? 1 : 0

  name                            = local.flow_logs_storage_account_name
  resource_group_name             = local.resource_group_name
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  tags                            = var.tags
}

resource "azurerm_network_watcher_flow_log" "vnet" {
  count = var.enable_vpc_flow_logs ? 1 : 0

  name                 = "${var.aks_cluster_name}-vnet-flow-log"
  network_watcher_name = var.network_watcher_name
  resource_group_name  = var.network_watcher_resource_group_name
  target_resource_id   = azurerm_virtual_network.virtual_network.id
  storage_account_id   = azurerm_storage_account.flow_logs[0].id
  enabled              = true
  retention_policy {
    enabled = true
    days    = var.log_retention_in_days
  }
}

# --- Argo Workflows artifact repository (opt-in) ---

resource "azurerm_storage_account" "argo_logs" {
  count = var.enable_artifact_archiving ? 1 : 0

  name                            = local.argo_logs_storage_account_name
  resource_group_name             = local.resource_group_name
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  tags                            = var.tags
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
  issuer                    = azurerm_kubernetes_cluster.aks_cluster.oidc_issuer_url
  subject                   = "system:serviceaccount:${var.argo_namespace}:${var.workflow_controller_service_account_name}"
}

resource "azurerm_role_assignment" "workflow_controller_artifacts" {
  count = var.enable_artifact_archiving && var.create_role_assignments ? 1 : 0

  scope                = azurerm_storage_account.argo_logs[0].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.workflow_controller_artifacts[0].principal_id
}

# --- Bastion ---

resource "azurerm_subnet" "bastion" {
  count = var.enable_bastion ? 1 : 0

  name                 = "AzureBastionSubnet"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
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

resource "azurerm_network_security_rule" "bastion" {
  for_each = { for name, rule in local.bastion_security_rules : name => rule if var.enable_bastion }

  name                        = each.key
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = "Allow"
  protocol                    = each.value.protocol
  source_port_range           = "*"
  destination_port_range      = each.value.destination_port_range
  destination_port_ranges     = each.value.destination_port_ranges
  source_address_prefix       = each.value.source_address_prefix
  source_address_prefixes     = each.value.source_address_prefixes
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = local.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion[0].name
}

resource "azurerm_subnet_network_security_group_association" "bastion" {
  count = var.enable_bastion ? 1 : 0

  subnet_id                 = azurerm_subnet.bastion[0].id
  network_security_group_id = azurerm_network_security_group.bastion[0].id

  # Azure rejects removing these rules while the NSG is still attached to
  # the Bastion subnet, so on destroy the association has to go first.
  depends_on = [azurerm_network_security_rule.bastion]
}

resource "azurerm_bastion_host" "bastion_host" {
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

# --- Per-env Workload Identities for pipeline pods ---

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
  issuer                    = azurerm_kubernetes_cluster.aks_cluster.oidc_issuer_url
  subject                   = "system:serviceaccount:${each.value.namespace}:${each.value.service_account_name}"
}

resource "azurerm_role_assignment" "deploy_identity" {
  for_each = var.create_role_assignments ? { for idx, ra in var.deploy_identity_role_assignments : idx => ra } : {}

  principal_id         = azurerm_user_assigned_identity.deploy_identity[each.value.identity_key].principal_id
  role_definition_name = each.value.role_definition_name
  scope                = each.value.scope
}

# --- Jump VM (opt-in, the only way to reach a private API server) ---

# Bastion only carries SSH and RDP to a VM. It can't forward to the API
# server's port 443, so a private cluster needs a VM inside the VNet to
# run kubectl from.
resource "azurerm_subnet" "jump_vm" {
  count = var.enable_jump_vm ? 1 : 0

  name                 = "${var.aks_cluster_name}-jump-snet"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = [var.jump_vm_subnet_address_prefix]

  lifecycle {
    precondition {
      condition     = var.enable_bastion && var.jump_vm_subnet_address_prefix != null
      error_message = "enable_jump_vm needs enable_bastion = true and jump_vm_subnet_address_prefix set: the VM has no public IP and is only reachable through Bastion."
    }
  }
}

resource "azurerm_network_security_group" "jump_vm" {
  count = var.enable_jump_vm ? 1 : 0

  name                = "${var.aks_cluster_name}-jump-nsg"
  location            = var.location
  resource_group_name = local.resource_group_name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "jump_vm_ssh_from_bastion" {
  count = var.enable_jump_vm ? 1 : 0

  name                        = "AllowSshFromBastion"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = var.bastion_subnet_address_prefix
  destination_address_prefix  = "*"
  resource_group_name         = local.resource_group_name
  network_security_group_name = azurerm_network_security_group.jump_vm[0].name
}

# The default rules allow everything inside the VNet, which would let any
# pod on the node subnet reach this VM's SSH port.
resource "azurerm_network_security_rule" "jump_vm_deny_vnet" {
  count = var.enable_jump_vm ? 1 : 0

  name                        = "DenyVnetInBound"
  priority                    = 4000
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = local.resource_group_name
  network_security_group_name = azurerm_network_security_group.jump_vm[0].name
}

resource "azurerm_subnet_network_security_group_association" "jump_vm" {
  count = var.enable_jump_vm ? 1 : 0

  subnet_id                 = azurerm_subnet.jump_vm[0].id
  network_security_group_id = azurerm_network_security_group.jump_vm[0].id

  depends_on = [
    azurerm_network_security_rule.jump_vm_ssh_from_bastion,
    azurerm_network_security_rule.jump_vm_deny_vnet,
  ]
}

resource "azurerm_subnet_nat_gateway_association" "jump_vm" {
  count = var.enable_jump_vm ? 1 : 0

  subnet_id      = azurerm_subnet.jump_vm[0].id
  nat_gateway_id = azurerm_nat_gateway.system_nat.id
}

resource "azurerm_network_interface" "jump_vm" {
  count = var.enable_jump_vm ? 1 : 0

  name                = "${var.aks_cluster_name}-jump-nic"
  location            = var.location
  resource_group_name = local.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.jump_vm[0].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "jump_vm" {
  count = var.enable_jump_vm ? 1 : 0

  name                            = "${var.aks_cluster_name}-jump"
  location                        = var.location
  resource_group_name             = local.resource_group_name
  size                            = var.jump_vm_size
  admin_username                  = var.aks_admin_username
  disable_password_authentication = true
  network_interface_ids           = [azurerm_network_interface.jump_vm[0].id]
  custom_data                     = base64encode(local.jump_vm_cloud_init)
  tags                            = var.tags

  admin_ssh_key {
    username   = var.aks_admin_username
    public_key = var.aks_public_ssh_key
  }

  # Entra ID SSH login needs a system-assigned identity on the VM.
  identity {
    type = "SystemAssigned"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  # Outbound has to work before cloud-init installs the CLI tools.
  depends_on = [
    azurerm_subnet_nat_gateway_association.jump_vm,
    azurerm_nat_gateway_public_ip_association.system_nat,
  ]
}

# Lets `az network bastion ssh --auth-type AAD` work for the groups in
# jump_vm_access.
resource "azurerm_virtual_machine_extension" "jump_vm_entra_login" {
  count = var.enable_jump_vm ? 1 : 0

  name                       = "AADSSHLoginForLinux"
  virtual_machine_id         = azurerm_linux_virtual_machine.jump_vm[0].id
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADSSHLoginForLinux"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  tags                       = var.tags
}

# Everything a group needs to get from Bastion to kubectl: sign in to the
# VM, see the three resources `az network bastion ssh` reads, and download
# a kubeconfig. What they can do in the cluster is a separate grant.
resource "azurerm_role_assignment" "jump_vm_login" {
  for_each = local.jump_vm_access

  scope                = azurerm_linux_virtual_machine.jump_vm[0].id
  role_definition_name = each.value.sudo ? "Virtual Machine Administrator Login" : "Virtual Machine User Login"
  principal_id         = each.value.principal_id
}

resource "azurerm_role_assignment" "jump_vm_reader" {
  for_each = local.jump_vm_access

  scope                = azurerm_linux_virtual_machine.jump_vm[0].id
  role_definition_name = "Reader"
  principal_id         = each.value.principal_id
}

resource "azurerm_role_assignment" "jump_vm_nic_reader" {
  for_each = local.jump_vm_access

  scope                = azurerm_network_interface.jump_vm[0].id
  role_definition_name = "Reader"
  principal_id         = each.value.principal_id
}

resource "azurerm_role_assignment" "jump_vm_bastion_reader" {
  for_each = local.jump_vm_access

  scope                = azurerm_bastion_host.bastion_host[0].id
  role_definition_name = "Reader"
  principal_id         = each.value.principal_id
}

resource "azurerm_role_assignment" "jump_vm_cluster_user" {
  for_each = local.jump_vm_access

  scope                = azurerm_kubernetes_cluster.aks_cluster.id
  role_definition_name = "Azure Kubernetes Service Cluster User Role"
  principal_id         = each.value.principal_id
}
