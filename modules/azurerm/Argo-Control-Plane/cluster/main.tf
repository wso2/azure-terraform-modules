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

resource "azurerm_resource_group" "this" {
  count    = var.create_resource_group ? 1 : 0
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

data "azurerm_client_config" "current" {}

locals {
  resource_group_name = var.create_resource_group ? azurerm_resource_group.this[0].name : var.resource_group_name

  # Storage account names: <=24 chars, lowercase alphanumeric only.
  cluster_name_sanitized         = lower(replace(var.aks_cluster_name, "-", ""))
  flow_logs_storage_account_name = coalesce(var.flow_logs_storage_account_name, "${substr(local.cluster_name_sanitized, 0, 24 - length("flowlogs"))}flowlogs")
  argo_logs_storage_account_name = coalesce(var.argo_logs_storage_account_name, "${substr(local.cluster_name_sanitized, 0, 24 - length("argologs"))}argologs")

  # Key Vault names: <=24 chars, no consecutive or trailing hyphens.
  cluster_secrets_key_vault_name = coalesce(var.cluster_secrets_key_vault_name, "${trimsuffix(substr(var.aks_cluster_name, 0, 24 - length("-kms")), "-")}-kms")
  eso_key_vault_name             = coalesce(var.eso_key_vault_name, "${trimsuffix(substr(var.aks_cluster_name, 0, 24 - length("-secrets")), "-")}-secrets")
}

resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  address_space       = [var.vnet_address_space]
  location            = var.location
  resource_group_name = local.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet" "nodes" {
  name                 = "${var.aks_cluster_name}-nodes-snet"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.node_subnet_address_prefix]
}

resource "azurerm_network_security_group" "nodes" {
  name                = "${var.aks_cluster_name}-nodes-nsg"
  location            = var.location
  resource_group_name = local.resource_group_name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "nodes" {
  for_each = { for r in var.network_security_rules : r.name => r }

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = local.resource_group_name
  network_security_group_name = azurerm_network_security_group.nodes.name
}

resource "azurerm_subnet_network_security_group_association" "nodes" {
  subnet_id                 = azurerm_subnet.nodes.id
  network_security_group_id = azurerm_network_security_group.nodes.id
}

resource "azurerm_public_ip" "nat" {
  name                = "${var.aks_cluster_name}-nat-pip"
  location            = var.location
  resource_group_name = local.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_nat_gateway" "this" {
  name                = "${var.aks_cluster_name}-nat"
  location            = var.location
  resource_group_name = local.resource_group_name
  sku_name            = "Standard"
  tags                = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "this" {
  nat_gateway_id       = azurerm_nat_gateway.this.id
  public_ip_address_id = azurerm_public_ip.nat.id
}

resource "azurerm_subnet_nat_gateway_association" "nodes" {
  subnet_id      = azurerm_subnet.nodes.id
  nat_gateway_id = azurerm_nat_gateway.this.id
}

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

  node_provisioning_profile {
    mode = "Manual"
  }

  default_node_pool {
    name                         = "system"
    vm_size                      = var.node_vm_size
    vnet_subnet_id               = azurerm_subnet.nodes.id
    zones                        = var.availability_zones
    auto_scaling_enabled         = true
    min_count                    = var.node_min_count
    max_count                    = var.node_max_count
    os_disk_size_gb              = 128
    max_pods                     = 110
    only_critical_addons_enabled = false

    # Explicit: left computed, it causes a perpetual diff that makes
    # kube_config unknown at plan time.
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

  # Follow-up apply only: the cluster identity needs Key Vault access first.
  dynamic "key_management_service" {
    for_each = var.enable_secrets_encryption ? [1] : []
    content {
      key_vault_key_id = azurerm_key_vault_key.cluster_secrets[0].id
    }
  }

  tags = var.tags

  depends_on = [
    azurerm_subnet_nat_gateway_association.nodes,
    azurerm_subnet_network_security_group_association.nodes,
  ]
}

# --- etcd secrets encryption (AKS KMS, Key Vault-backed) ---

resource "azurerm_key_vault" "cluster_secrets" {
  count = var.enable_secrets_encryption ? 1 : 0

  name                       = local.cluster_secrets_key_vault_name
  location                   = var.location
  resource_group_name        = local.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
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
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "kms" {
  count = var.enable_secrets_encryption ? 1 : 0

  scope                = azurerm_key_vault.cluster_secrets[0].id
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = azurerm_kubernetes_cluster.this.identity[0].principal_id
}

# --- External Secrets Operator Key Vault and identity ---

resource "azurerm_key_vault" "eso" {
  name                       = local.eso_key_vault_name
  location                   = var.location
  resource_group_name        = local.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  rbac_authorization_enabled = true
  purge_protection_enabled   = true
  soft_delete_retention_days = 90
  tags                       = var.tags
}

# Lets whoever runs `terraform apply` seed the secrets ESO syncs.
resource "azurerm_role_assignment" "eso_secrets_officer" {
  count = var.create_role_assignments ? 1 : 0

  scope                = azurerm_key_vault.eso.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_user_assigned_identity" "eso" {
  name                = "${var.aks_cluster_name}-eso"
  location            = var.location
  resource_group_name = local.resource_group_name
  tags                = var.tags
}

resource "azurerm_federated_identity_credential" "eso" {
  name                      = "${var.aks_cluster_name}-eso"
  user_assigned_identity_id = azurerm_user_assigned_identity.eso.id
  audience                  = ["api://AzureADTokenExchange"]
  issuer                    = azurerm_kubernetes_cluster.this.oidc_issuer_url
  subject                   = "system:serviceaccount:${var.eso_namespace}:external-secrets"
}

resource "azurerm_role_assignment" "eso" {
  count = var.create_role_assignments ? 1 : 0

  scope                = azurerm_key_vault.eso.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.eso.principal_id
}

# --- NSG Flow Logs (opt-in). Requires an existing regional Network Watcher. ---

resource "azurerm_storage_account" "flow_logs" {
  count = var.enable_vpc_flow_logs ? 1 : 0

  name                     = local.flow_logs_storage_account_name
  resource_group_name      = local.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}

resource "azurerm_network_watcher_flow_log" "nodes" {
  count = var.enable_vpc_flow_logs ? 1 : 0

  name                 = "${var.aks_cluster_name}-nodes-flow-log"
  network_watcher_name = var.network_watcher_name
  resource_group_name  = var.network_watcher_resource_group_name
  target_resource_id   = azurerm_network_security_group.nodes.id
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

# --- Azure Bastion (opt-in admin access path) ---

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
