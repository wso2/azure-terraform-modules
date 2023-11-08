# -------------------------------------------------------------------------------------
#
# Copyright (c) 2023, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

resource "azuredevops_serviceendpoint_azurerm" "devops_serviceendpoint_azurerm" {
  project_id                = var.project_id
  service_endpoint_name     = var.azurerm_service_endpoint_name
  azurerm_spn_tenantid      = var.tenant_id
  azurerm_subscription_id   = var.subscription_id
  azurerm_subscription_name = var.subscription_name
  description               = var.description

  credentials {
    serviceprincipalid  = var.service_principal_id
    serviceprincipalkey = var.service_principal_key
  }
}
