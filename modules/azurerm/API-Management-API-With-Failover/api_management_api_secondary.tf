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

resource "azurerm_api_management_api" "api_management_api_secondary" {
  name                  = join("-", [var.api_abbreviation, var.api_name])
  api_management_name   = var.secondary_api_management_name
  resource_group_name   = var.resource_group_name
  revision              = var.api_revision
  api_type              = var.api_type
  display_name          = var.display_name
  path                  = var.path
  protocols             = var.protocols
  service_url           = var.backend_service_url
  subscription_required = var.subscription_required
}

resource "azurerm_api_management_api_policy" "api_management_api_policy_secondary" {
  api_name            = azurerm_api_management_api.api_management_api_secondary.name
  api_management_name = var.secondary_api_management_name
  resource_group_name = var.resource_group_name
  xml_content         = templatefile(var.xml_template_file_path, var.xml_template_vars)
}
