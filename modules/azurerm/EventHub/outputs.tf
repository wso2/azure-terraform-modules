output "eventhub_name" {
  depends_on = [azurerm_eventhub.eventhub]
  value = azurerm_eventhub.eventhub.name
}

output "eventhub_id" {
  depends_on = [azurerm_eventhub.eventhub]
  value = azurerm_eventhub.eventhub.id
}
