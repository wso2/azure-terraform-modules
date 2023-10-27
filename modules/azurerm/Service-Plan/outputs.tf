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

output "service_plan_id" {
  depends_on = [azurerm_service_plan.service_plan]
  value      = azurerm_service_plan.service_plan.id
}

output "service_plan_name" {
  depends_on = [azurerm_service_plan.service_plan]
  value      = azurerm_service_plan.service_plan.name
}

output "service_plan_maximum_elastic_worker_count" {
  depends_on = [azurerm_service_plan.service_plan]
  value      = azurerm_service_plan.service_plan.maximum_elastic_worker_count
}
