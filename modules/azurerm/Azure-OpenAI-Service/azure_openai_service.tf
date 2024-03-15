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
  tags                               = var.tags
}

resource "azurerm_cognitive_deployment" "azure_openai_deployment" {
  cognitive_account_id   = azurerm_cognitive_account.azure_openai_account.id
  name                   = join("-", [var.cognitive_deployment_abbreviation, var.cognitive_deployment_name])
  rai_policy_name        = var.rai_policy_name
  version_upgrade_option = var.version_upgrade_option

  model {
    format  = var.cognitive_model_format
    name    = var.cognitive_model_name
    version = var.cognitive_model_version
  }
  scale {
    type     = var.deployment_sku_scale_type
    capacity = var.deployment_sku_scale_capacity
  }
}
