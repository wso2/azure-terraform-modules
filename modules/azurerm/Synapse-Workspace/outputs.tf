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

output "id" {
  description = "The ID of the Synapse Workspace"
  value       = azurerm_synapse_workspace.synapse.id
}

output "connectivity_endpoints" {
  description = "A list of connectivity endpoints for the Synapse Workspace"
  value       = azurerm_synapse_workspace.synapse.connectivity_endpoints
}

output "managed_resource_group_name" {
  description = "The name of the Managed Resource Group for the Synapse Workspace"
  value       = azurerm_synapse_workspace.synapse.managed_resource_group_name
}