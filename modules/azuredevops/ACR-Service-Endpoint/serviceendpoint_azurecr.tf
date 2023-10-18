# -------------------------------------------------------------------------------------
#
# Copyright (c) 2020, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

resource "azuredevops_serviceendpoint_azurecr" "serviceendpoint_azurecr" {
  project_id                = var.project_id
  service_endpoint_name     = join("-", [var.project, var.service_endpoint_name])
  resource_group            = var.acr_rg_name
  description               = var.description
  azurecr_spn_tenantid      = var.acr_spn_tenant_id
  azurecr_name              = var.acr_name
  azurecr_subscription_id   = var.acr_subscription_id
  azurecr_subscription_name = var.acr_subscription_name
}
