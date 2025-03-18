# -------------------------------------------------------------------------------------
#
# Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

resource "azuread_application_federated_identity_credential" "federated_credentials" {
  application_id = var.ad_application_id
  display_name   = join("-", [var.federated_credential_abbreviation, var.name])
  description    = var.description
  audiences      = var.audiences
  issuer         = var.oidc_issuer_url
  subject        = var.subject
}
