# -------------------------------------------------------------------------------------
#
# Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "internal_lb_id" {
  description = "The ID of the Load Balancer in which to create the Backend Address Pool. Changing this forces a new resource to be created."
  type        = string
}

variable "lb_backend_address_pool_name" {
  description = "Specifies the name of the Backend Address Pool. Changing this forces a new resource to be created."
  type        = string
  default     = "BackEndAddressPool"
}
