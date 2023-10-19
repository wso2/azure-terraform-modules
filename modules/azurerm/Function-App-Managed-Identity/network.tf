# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

resource "azurerm_app_service_virtual_network_swift_connection" "function_app_vnet_integration" {
  count          = var.subnet_id != null ? 1 : 0
  app_service_id = azurerm_function_app.function_app_with_managed_identity.id
  subnet_id      = var.subnet_id
  depends_on = [
    azurerm_function_app.function_app_with_managed_identity
  ]
}
