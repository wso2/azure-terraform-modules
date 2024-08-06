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

resource "azurerm_function_app" "function_app_with_managed_identity" {
  name                       = var.function_app_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = var.app_service_plan_id
  os_type                    = var.os_type
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  app_settings               = var.app_settings
  version                    = var.app_runtime_version
  client_cert_mode           = var.client_cert_mode
  https_only                 = var.https_only
  tags                       = var.tags

  site_config {
    linux_fx_version          = var.linux_fx_version
    use_32_bit_worker_process = var.use_32_bit_worker_process
    always_on                 = var.always_on
    health_check_path         = var.health_check_path
    ftps_state                = var.ftps_state
  }

  identity {
    type = var.managed_identity_type
  }

  lifecycle {
    ignore_changes = [
      tags["hidden-link: /app-insights-conn-string"],
      tags["hidden-link: /app-insights-instrumentation-key"],
      tags["hidden-link: /app-insights-resource-id"]
    ]
  }
}
