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
resource "azurerm_eventgrid_system_topic_event_subscription" "eventgrid_system_topic_event_subscription" {
  name                 = join("-", ["evgs", var.project, var.application_name, var.environment, var.location, var.padding])
  system_topic         = var.system_topic
  resource_group_name  = var.resource_group_name
  included_event_types = var.included_event_types

  webhook_endpoint {
    url = var.webhook_endpoint_url
    max_events_per_batch = var.webhook_max_events_per_batch
    preferred_batch_size_in_kilobytes = var.webhook_max_preferred_batch_size_in_kilobytes
  }

  retry_policy {
    max_delivery_attempts = var.retry_policy_max_delivery_attempts
    event_time_to_live    = var.event_time_to_live
  }
}
