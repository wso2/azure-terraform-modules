# -------------------------------------------------------------------------------------
#
# Copyright (c) 2020, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

resource "azuredevops_resource_authorization" "devops_resource_authorization" {
  project_id    = var.project_id
  resource_id   = var.resource_id
  authorized    = var.authorized
  definition_id = var.definition_id
  type          = var.authorized_type
}
