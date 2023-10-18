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

locals {
  vnet_src_parts               = split("/", var.vnet_src_id)
  vnet_src_name                = element(local.vnet_src_parts, 8)
  vnet_src_subscription_id     = element(local.vnet_src_parts, 2)
  vnet_src_resource_group_name = element(local.vnet_src_parts, 4)

  vnet_dest_parts               = split("/", var.vnet_dest_id)
  vnet_dest_name                = element(local.vnet_dest_parts, 8)
  vnet_dest_subscription_id     = element(local.vnet_dest_parts, 2)
  vnet_dest_resource_group_name = element(local.vnet_dest_parts, 4)
}
