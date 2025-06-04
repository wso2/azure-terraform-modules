# -------------------------------------------------------------------------------------
#
# Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

resource "azurerm_cognitive_account" "azure_openai_account" {
  kind                               = var.kind
  location                           = var.location
  resource_group_name                = var.resource_group_name
  name                               = join("-", [var.cognitive_account_abbreviation, var.cognitive_account_name])
  sku_name                           = var.account_sku_name
  dynamic_throttling_enabled         = var.dynamic_throttling_enabled
  outbound_network_access_restricted = var.outbound_network_access_restricted
  public_network_access_enabled      = var.public_network_access_enabled
  custom_subdomain_name              = join("-", [var.cognitive_account_abbreviation, var.custom_subdomain_name])

  dynamic "network_acls" {
    for_each = var.network_acls_enabled ? [1] : []

    content {
      default_action = var.network_acls_default_action
      bypass         = var.network_acls_bypass
      ip_rules       = var.network_acls_ip_rules
    }
  }

  tags = var.tags
}

resource "azurerm_cognitive_deployment" "azure_openai_deployment" {
  for_each               = var.azure_openai_deployments
  cognitive_account_id   = azurerm_cognitive_account.azure_openai_account.id
  name                   = join("-", [var.cognitive_deployment_abbreviation, each.value.cognitive_deployment_name])
  rai_policy_name        = var.rai_policy_name
  version_upgrade_option = var.version_upgrade_option

  model {
    format  = each.value.cognitive_model_format
    name    = each.value.cognitive_model_name
    version = each.value.cognitive_model_version
  }
  sku {
    name     = each.value.deployment_sku_name
    capacity = each.value.deployment_sku_capacity
  }
}
