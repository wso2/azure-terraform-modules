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

output "data_collection_endpoint_id" {
  depends_on = [azurerm_monitor_data_collection_endpoint.data_collection_endpoint]
  value      = azurerm_monitor_data_collection_endpoint.data_collection_endpoint.id
}

output "configuration_access_endpoint" {
  depends_on = [azurerm_monitor_data_collection_endpoint.data_collection_endpoint]
  value      = azurerm_monitor_data_collection_endpoint.data_collection_endpoint.configuration_access_endpoint
}

output "logs_ingestion_endpoint" {
  depends_on = [azurerm_monitor_data_collection_endpoint.data_collection_endpoint]
  value      = azurerm_monitor_data_collection_endpoint.data_collection_endpoint.logs_ingestion_endpoint
}
