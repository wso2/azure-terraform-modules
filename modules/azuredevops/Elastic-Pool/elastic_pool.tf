# -------------------------------------------------------------------------------------
#
# Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

resource "azuredevops_elastic_pool" "elastic_pool" {
  name                   = var.pool_name
  service_endpoint_id    = var.service_endpoint_id
  service_endpoint_scope = var.service_endpoint_scope
  desired_idle           = var.desired_idle
  max_capacity           = var.max_capacity
  project_id             = var.project_id
  azure_resource_id      = var.vmss_resource_id
  recycle_after_each_use = var.recycle_after_each_use
  time_to_live_minutes   = var.time_to_live_minutes
  agent_interactive_ui   = var.agent_interactive_ui
  auto_provision         = var.auto_provision
  auto_update            = var.auto_update
}
