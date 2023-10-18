resource "azurerm_eventhub" "eventhub" {
  name                = join("-",
    [
      "evh",
      var.project,
      var.application_name,
      var.environment,
      var.location,
      var.padding
    ]
  )
  namespace_name      = var.namespace_name
  resource_group_name = var.resource_group_name
  partition_count     = var.partition_count
  message_retention   = var.message_retention
}
