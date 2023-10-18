# -------------------------------------------------------------------------------------
#
# Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

resource "azurerm_automation_variable_string" "automation_variable_string" {
  for_each                = var.automation_variables
  automation_account_name = var.automation_account_name
  resource_group_name     = var.resource_group_name
  name                    = join("-", ["av", each.value.variable_name]) 
  value                   = each.value.variable_value
}
