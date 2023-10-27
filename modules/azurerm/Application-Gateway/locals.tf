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

locals {
  appgw_name                             = join("-", ["agw", var.project, var.environment, var.location, var.padding])
  gateway_ip_configuration_name          = join("-", [var.project, var.environment, var.name, "gw-ip-config"])
  frontend_public_ip_configuration_name  = join("-", [var.project, var.environment, var.name, "public-ip-config"])
  frontend_private_ip_configuration_name = join("-", [var.project, var.environment, var.name, "private-ip-config"])
}
