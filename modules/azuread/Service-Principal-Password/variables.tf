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

variable "sp_internal_id" {
  description = "The internal ID of the service principal."
  type        = string
}

variable "rotation_time_in_months" {
  default     = 6
  description = "The time in months after which the service principal password will expire."
  type        = number
}

variable "display_name" {
  default     = null
  description = "The display name of the service principal."
  type        = string
}
