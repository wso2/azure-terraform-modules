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

resource "azurerm_federated_identity_credential" "federated_credentials" {
  name                = var.federated_identity_name
  resource_group_name = var.resource_group_name
  parent_id           = var.azurerm_user_assigned_identity_principal_id
  audience            = var.federated_audience
  issuer              = var.oidc_issuer_url
  subject             = "system:serviceaccount:${workload_sa_namespace}:${workload_sa_name}"
}
