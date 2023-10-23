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
resource "azurerm_dashboard" "dashboard" {
  name                 = join("-", ["dashb", var.project, var.application_name, var.environment, var.location, var.padding])
  resource_group_name  = var.resource_group_name
  location             = var.location
  tags                 = var.tags
  dashboard_properties = templatefile(var.template_path, var.template_vars)
}
