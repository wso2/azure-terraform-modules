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

resource "random_uuid" "uuid" {}

resource "azurerm_application_insights_workbook" "application_insights_workbook" {
  name                = random_uuid.uuid.result
  resource_group_name = var.resource_group_name
  location            = var.location
  display_name        = join("-", ["wb", var.workbook_display_name])
  source_id           = var.source_resource_id
  category            = var.category
  description         = var.description
  data_json           = var.template_data_json
  tags                = var.tags
}
