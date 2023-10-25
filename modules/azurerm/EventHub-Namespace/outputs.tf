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

output "eventhub_namespace_name" {
  depends_on = [azurerm_eventhub_namespace.eventhub_namespace]
  value      = azurerm_eventhub_namespace.eventhub_namespace.name
}

output "eventhub_namespace_id" {
  depends_on  = [azurerm_eventhub_namespace.eventhub_namespace]
  value       = azurerm_eventhub_namespace.eventhub_namespace.id
  description = "Event Hub Namespace Id"
}

output "eventhub_namespace_primary_connection_string" {
  depends_on  = [azurerm_eventhub_namespace.eventhub_namespace]
  value       = azurerm_eventhub_namespace.eventhub_namespace.default_primary_connection_string
  description = "Event Hub Namespace primary connection string"
}

output "eventhub_namespace_secondary_connection_string" {
  depends_on  = [azurerm_eventhub_namespace.eventhub_namespace]
  value       = azurerm_eventhub_namespace.eventhub_namespace.default_secondary_connection_string
  description = "Event Hub Namespace secondary connection string"
}
