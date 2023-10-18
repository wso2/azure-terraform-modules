# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------
output "scale_set_agent_linux_virtual_machine_scale_set_id" {
  value = azurerm_linux_virtual_machine_scale_set.scale_set_agent_linux_virtual_machine_scale_set.id
}

output "scale_set_agent_subnet_id" {
  value = azurerm_subnet.scale_set_agent_subnet.id
}

output "network_security_group_id" {
  value = azurerm_network_security_group.scale_set_agent_subnet_nsg.id
}
