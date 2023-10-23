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

variable "group_object_id" {
  description = "The object ID of the group you want to add the member to. Changing this forces a new resource to be created."
  type        = string
}
variable "member_object_id" {
  description = "The object ID of the principal you want to add as a member to the group. Supported object types are Users, Groups or Service Principals. Changing this forces a new resource to be created."
  type        = string
}
