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
resource "azurerm_mssql_server" "mssql_server" {
  name                          = join("-", ["sql", var.project, var.application_name, var.environment, var.location, var.padding])
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = var.db_server_version
  administrator_login           = var.db_server_administrator_login
  administrator_login_password  = var.db_server_administrator_login_password
  minimum_tls_version           = var.db_server_minimum_tls_version
  public_network_access_enabled = var.db_server_public_network_access_enabled
  tags                          = var.default_tags
  lifecycle {
    prevent_destroy = true
  }
  identity {
    type = var.mssql_identity_type
  }

  azuread_administrator {
    login_username = var.azuread_administrator_login_username
    object_id      = var.azuread_administrator_object_id
    tenant_id      = var.azuread_administrator_tenant_id
    /*
    When "azuread_authentication_only" is true, "administrator_login" and "administrator_login_password" properties
    can be omitted as only AD user or group logins are permitted.
    */
    azuread_authentication_only      = false
  }
}
