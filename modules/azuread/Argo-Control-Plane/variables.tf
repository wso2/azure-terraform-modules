# -------------------------------------------------------------------------------------
#
# Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "application_name" {
  description = "Display name for the Entra ID app registration"
  type        = string
  default     = "argo-rnd-portal"
}

variable "group_membership_claims" {
  description = "Configures the groups claim issued in a token this app expects. One or more of: None, SecurityGroup, DirectoryRole, ApplicationGroup, All."
  type        = list(string)
  default     = ["SecurityGroup"]
}

variable "manage_redirect_uris" {
  description = "Whether to create the azuread_application_redirect_uris resource at all. Must be a plain bool the caller controls directly - do not derive this from whether redirect_uris happens to be non-empty, since that value can be unknown until apply and count/for_each can't depend on it."
  type        = bool
  default     = false
}

variable "redirect_uris" {
  description = "Redirect URIs to assign to the application. Only used when manage_redirect_uris = true; this value itself may safely be unknown until apply (e.g. built from a LoadBalancer hostname)."
  type        = list(string)
  default     = []
}

variable "redirect_uri_type" {
  description = "The type of redirect URIs in redirect_uris. One of: PublicClient, SPA, Web."
  type        = string
  default     = "Web"
}

variable "sp_app_role_assignment_required" {
  description = "Whether the service principal requires an app role assignment to a user or group before Entra ID will issue a token to the application"
  type        = bool
  default     = false
}

variable "sp_password_display_name" {
  description = "Display name for the service principal's rotating password"
  type        = string
  default     = null
}

variable "sp_password_rotation_months" {
  description = "How often the service principal password rotates"
  type        = number
  default     = 6
}

variable "group_name_prefix" {
  description = "Prefix for the 4 RBAC tier group display names (e.g. \"grp-asgardeo-argo\" produces \"grp-asgardeo-argo-nonprod-reader\", etc.)"
  type        = string
  default     = "grp-asgardeo-argo"
}
