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

variable "resource_id" {
  description = "Azure resource ID for target resource to assign role"
  type        = string
}

variable "role_definition_name" {
  description = "Name of the role definition to assign"
  type        = string
}

variable "principal_id" {
  description = "Azure AD principal ID to assign role"
  type        = string
}
