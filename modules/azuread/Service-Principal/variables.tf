# -------------------------------------------------------------------------------------
#
# Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may app_role_assignment_requiredtent.
#
# --------------------------------------------------------------------------------------

variable "ad_application_client_id" {
  description = "The application Client ID of the application you want to assign the role to."
  type        = string
}

variable "app_role_assignment_required" {
  default     = false
  description = "Whether this service principal requires an app role assignment to a user or group before Azure AD will issue a user or access token to the application."
  type        = bool
}
