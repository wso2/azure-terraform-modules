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

output "front_door_waf_object" {
  depends_on = [azurerm_frontdoor_firewall_policy.front_door_waf_policy]
  value = azurerm_frontdoor_firewall_policy.front_door_waf_policy
}

output "azure_frontdoor_waf_policy_ids" {
  description = "The ID of the FrontDoor Firewall Policy."
  value       = [
    for front_door_waf_policy in azurerm_frontdoor_firewall_policy.front_door_waf_policy : front_door_waf_policy.id
  ]
  depends_on  = [azurerm_frontdoor_firewall_policy.front_door_waf_policy]
}
