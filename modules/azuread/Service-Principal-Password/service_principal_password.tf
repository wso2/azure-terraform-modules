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

resource "time_rotating" "password_rotating_time" {
  rotation_months = var.rotation_time_in_months
  lifecycle {
    create_before_destroy = true
  }
}
resource "azuread_service_principal_password" "service_principal_password" {
  service_principal_id = var.sp_internal_id
  display_name         = var.display_name
  rotate_when_changed = {
    rotation = time_rotating.password_rotating_time.id
  }
  lifecycle {
    create_before_destroy = true
  }
}
