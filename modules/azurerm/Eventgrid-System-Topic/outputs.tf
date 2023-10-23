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
output "eventgrid_system_topic_id" {
  depends_on = [azurerm_eventgrid_system_topic.eventgrid_system_topic]
  value      = azurerm_eventgrid_system_topic.eventgrid_system_topic.id
}

output "eventgrid_system_topic_metric_arm_resource_id" {
  depends_on = [azurerm_eventgrid_system_topic.eventgrid_system_topic]
  value      = azurerm_eventgrid_system_topic.eventgrid_system_topic.metric_arm_resource_id
}

output "eventgrid_system_topic_name" {
  depends_on = [azurerm_eventgrid_system_topic.eventgrid_system_topic]
  value      = azurerm_eventgrid_system_topic.eventgrid_system_topic.name
}
