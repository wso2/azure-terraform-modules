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

resource "azurerm_monitor_data_collection_rule_association" "data_collection_rule_association" {
  name                    = join("-", ["dcra", var.project, var.association_name, var.environment])
  data_collection_rule_id = var.data_collection_rule_id
  target_resource_id      = var.target_resource_id
}
