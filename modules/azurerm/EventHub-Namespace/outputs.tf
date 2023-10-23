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
