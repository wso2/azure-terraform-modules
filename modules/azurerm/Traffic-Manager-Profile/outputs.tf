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

output "traffic_manager_profile_name" {
  value      = azurerm_traffic_manager_profile.traffic_manager_profile.name
  depends_on = [azurerm_traffic_manager_profile.traffic_manager_profile]
}

output "traffic_manager_fqdn" {
  value      = azurerm_traffic_manager_profile.traffic_manager_profile.fqdn
  depends_on = [azurerm_traffic_manager_profile.traffic_manager_profile]
}

output "traffic_manager_id" {
  value      = azurerm_traffic_manager_profile.traffic_manager_profile.id
  depends_on = [azurerm_traffic_manager_profile.traffic_manager_profile]
}
