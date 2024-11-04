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

resource "azurerm_linux_function_app" "linux_function_app" {
  name                       = join("-", ["func", var.linux_function_app_name])
  resource_group_name        = var.resource_group_name
  location                   = var.location
  app_settings               = var.app_settings
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  service_plan_id            = var.service_plan_id
  virtual_network_subnet_id  = var.function_app_subnet_id
  tags                       = var.tags

  site_config {
    always_on                              = var.is_function_app_always_on
    vnet_route_all_enabled                 = var.is_route_all
    worker_count                           = var.worker_count
    application_insights_key               = var.application_insights_key
    application_insights_connection_string = var.application_insights_connection_string

    application_stack {
      java_version            = var.java_version
      dotnet_version          = var.dotnet_version
      node_version            = var.node_version
      python_version          = var.python_version
      powershell_core_version = var.powershell_core_version
    }

    dynamic "ip_restriction" {
      for_each = var.access_restriction_ip_address

      content {
        priority   = ip_restriction.value["priority"]
        name       = ip_restriction.value["name"]
        ip_address = ip_restriction.value["ip_address"]
        action     = ip_restriction.value["action"]

        dynamic "headers" {
          for_each = ip_restriction.value["headers"] != null ? ["true"] : []

          content {
            x_azure_fdid      = ip_restriction.value["headers"].x_azure_fdid
            x_fd_health_probe = ip_restriction.value["headers"].x_fd_health_probe
            x_forwarded_for   = ip_restriction.value["headers"].x_forwarded_for
            x_forwarded_host  = ip_restriction.value["headers"].x_forwarded_host
          }
        }
      }
    }

    dynamic "ip_restriction" {
      for_each = var.access_restriction_service_tag

      content {
        priority    = ip_restriction.value["priority"]
        name        = ip_restriction.value["name"]
        service_tag = ip_restriction.value["service_tag"]
        action      = ip_restriction.value["action"]

        dynamic "headers" {
          for_each = ip_restriction.value["headers"] != null ? ["true"] : []

          content {
            x_azure_fdid      = ip_restriction.value["headers"].x_azure_fdid
            x_fd_health_probe = ip_restriction.value["headers"].x_fd_health_probe
            x_forwarded_for   = ip_restriction.value["headers"].x_forwarded_for
            x_forwarded_host  = ip_restriction.value["headers"].x_forwarded_host
          }
        }
      }
    }

    dynamic "ip_restriction" {
      for_each = var.access_restriction_vnet

      content {
        priority   = ip_restriction.value["priority"]
        name       = ip_restriction.value["name"]
        ip_address = ip_restriction.value["ip_address"]
        action     = ip_restriction.value["action"]

        dynamic "headers" {
          for_each = ip_restriction.value["headers"] != null ? ["true"] : []

          content {
            x_azure_fdid      = ip_restriction.value["headers"].x_azure_fdid
            x_fd_health_probe = ip_restriction.value["headers"].x_fd_health_probe
            x_forwarded_for   = ip_restriction.value["headers"].x_forwarded_for
            x_forwarded_host  = ip_restriction.value["headers"].x_forwarded_host
          }
        }
      }
    }
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
