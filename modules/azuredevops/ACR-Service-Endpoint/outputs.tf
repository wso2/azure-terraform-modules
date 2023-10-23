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

output "id" {
  value      = azuredevops_serviceendpoint_azurecr.serviceendpoint_azurecr.id
  depends_on = [azuredevops_serviceendpoint_azurecr.serviceendpoint_azurecr]
}

output "service_endpoint_name" {
  value      = azuredevops_serviceendpoint_azurecr.serviceendpoint_azurecr.service_endpoint_name
  depends_on = [azuredevops_serviceendpoint_azurecr.serviceendpoint_azurecr]
}
