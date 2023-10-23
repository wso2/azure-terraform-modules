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

# Create network interface
resource "azurerm_network_interface" "automation_vm_nic" {
    name                      = join("-", ["nic", var.project, var.application_name, var.environment, var.location, var.padding])
    location                  = var.location
    resource_group_name       = var.resource_group_name
    
    ip_configuration {
        name                          = join("-", ["nic", var.project, var.application_name, var.environment, var.location, var.padding])
        subnet_id                     = var.subnet_id
        private_ip_address_allocation = "Dynamic"
    }
    tags = var.default_tags
}
