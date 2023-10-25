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

resource "azurerm_monitor_data_collection_rule" "data_collection_rule" {
  name                        = join("-", ["dcr", var.project, var.rule_name, var.environment, var.location, var.padding])
  resource_group_name         = var.resource_group_name
  location                    = var.location
  kind                        = var.kind
  data_collection_endpoint_id = var.data_collection_endpoint_id
  tags                        = var.tags

  data_flow {
    destinations  = var.data_flow_destinations
    streams       = var.data_flow_streams
    transform_kql = var.data_flow_transform_kql
    output_stream = var.data_flow_output_stream
  }

  destinations {
    log_analytics {
      name                  = var.destination_la_name
      workspace_resource_id = var.destination_la_workspace_resource_id
    }
  }

  dynamic "data_sources" {
    for_each = var.data_sources_syslog_name != null ? [1] : []
    content {
      syslog {
        name           = var.data_sources_syslog_name
        facility_names = var.data_sources_syslog_facility_names
        log_levels     = var.data_sources_syslog_log_levels
      }
    }
  }

  dynamic "stream_declaration" {
    for_each = var.stream_declaration_name != null ? [1] : []
    content {
      stream_name = var.stream_declaration_name

      dynamic "column" {
        for_each = var.stream_declaration_columns
        content {
          name = column.value["name"]
          type = column.value["type"]
        }
      }
    }
  }
}
