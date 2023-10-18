# -------------------------------------------------------------------------------------
#
# Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

output "app_service_plan_id" {
  depends_on  = [azurerm_app_service_plan.app_service_plan]
  value       = azurerm_app_service_plan.app_service_plan.id
}

output "app_service_plan_name" {
  depends_on  = [azurerm_app_service_plan.app_service_plan]
  value       = azurerm_app_service_plan.app_service_plan.name
}

output "app_service_maximum_worker_count" {
  depends_on  = [azurerm_app_service_plan.app_service_plan]
  value       = azurerm_app_service_plan.app_service_plan.maximum_number_of_workers
}
