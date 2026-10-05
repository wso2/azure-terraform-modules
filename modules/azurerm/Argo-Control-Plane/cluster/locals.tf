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

locals {
  resource_group_name = var.create_resource_group ? azurerm_resource_group.resource_group[0].name : var.resource_group_name

  # Storage account names: <=24 chars, lowercase alphanumeric only.
  cluster_name_sanitized         = lower(replace(var.aks_cluster_name, "-", ""))
  flow_logs_storage_account_name = coalesce(var.flow_logs_storage_account_name, "${substr(local.cluster_name_sanitized, 0, 24 - length("flowlogs"))}flowlogs")
  argo_logs_storage_account_name = coalesce(var.argo_logs_storage_account_name, "${substr(local.cluster_name_sanitized, 0, 24 - length("argologs"))}argologs")

  # Key Vault names: <=24 chars, no consecutive or trailing hyphens.
  cluster_secrets_key_vault_name = coalesce(var.cluster_secrets_key_vault_name, "${trimsuffix(substr(var.aks_cluster_name, 0, 24 - length("-kms")), "-")}-kms")
  eso_key_vault_name             = coalesce(var.eso_key_vault_name, "${trimsuffix(substr(var.aks_cluster_name, 0, 24 - length("-secrets")), "-")}-secrets")

  # The rule set Azure requires on the AzureBastionSubnet's NSG.
  bastion_security_rules = {
    AllowHttpsInBound = {
      priority                   = 200
      direction                  = "Inbound"
      protocol                   = "Tcp"
      destination_port_range     = "443"
      destination_port_ranges    = null
      source_address_prefix      = var.bastion_allow_https_internet_inbound ? "Internet" : null
      source_address_prefixes    = var.bastion_allow_https_internet_inbound ? null : var.bastion_public_address_prefixes
      destination_address_prefix = "*"
    }
    AllowGatewayManagerInBound = {
      priority                   = 210
      direction                  = "Inbound"
      protocol                   = "Tcp"
      destination_port_range     = "443"
      destination_port_ranges    = null
      source_address_prefix      = "GatewayManager"
      source_address_prefixes    = null
      destination_address_prefix = "*"
    }
    AllowAzureLoadBalancerInBound = {
      priority                   = 220
      direction                  = "Inbound"
      protocol                   = "Tcp"
      destination_port_range     = "443"
      destination_port_ranges    = null
      source_address_prefix      = "AzureLoadBalancer"
      source_address_prefixes    = null
      destination_address_prefix = "*"
    }
    AllowBastionHostCommunication = {
      priority                   = 230
      direction                  = "Inbound"
      protocol                   = "Tcp"
      destination_port_range     = null
      destination_port_ranges    = ["8080", "5701"]
      source_address_prefix      = "VirtualNetwork"
      source_address_prefixes    = null
      destination_address_prefix = "VirtualNetwork"
    }
    AllowSshRdpOutBound = {
      priority                   = 200
      direction                  = "Outbound"
      protocol                   = "*"
      destination_port_range     = null
      destination_port_ranges    = ["3389", "22"]
      source_address_prefix      = "*"
      source_address_prefixes    = null
      destination_address_prefix = "VirtualNetwork"
    }
    AllowAzureCloudOutBound = {
      priority                   = 210
      direction                  = "Outbound"
      protocol                   = "Tcp"
      destination_port_range     = "443"
      destination_port_ranges    = null
      source_address_prefix      = "*"
      source_address_prefixes    = null
      destination_address_prefix = "AzureCloud"
    }
    AllowBastionCommunication = {
      priority                   = 220
      direction                  = "Outbound"
      protocol                   = "Tcp"
      destination_port_range     = null
      destination_port_ranges    = ["8080", "5701"]
      source_address_prefix      = "VirtualNetwork"
      source_address_prefixes    = null
      destination_address_prefix = "VirtualNetwork"
    }
    AllowGetSessionInformation = {
      priority                   = 230
      direction                  = "Outbound"
      protocol                   = "*"
      destination_port_range     = "80"
      destination_port_ranges    = null
      source_address_prefix      = "*"
      source_address_prefixes    = null
      destination_address_prefix = "Internet"
    }
  }
}
