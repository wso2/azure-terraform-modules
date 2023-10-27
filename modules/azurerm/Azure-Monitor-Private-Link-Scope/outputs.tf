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

output "monitor_private_link_scope_id" {
  value = azurerm_monitor_private_link_scope.monitor_private_link_scope.id
}

output "monitor_private_link_scope_name" {
  value = azurerm_monitor_private_link_scope.monitor_private_link_scope.name
}
