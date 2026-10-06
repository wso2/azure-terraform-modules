# -------------------------------------------------------------------------------------
#
# Copyright (c) 2026, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
#
# WSO2 LLC. licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the
# specific language governing permissions and limitations
# under the License.
#
# --------------------------------------------------------------------------------------

variable "application_name" {
  description = "Display name for the Entra ID app registration"
  type        = string
}

variable "group_membership_claims" {
  description = "Configures the groups claim issued in a token this app expects. One or more of: None, SecurityGroup, DirectoryRole, ApplicationGroup, All."
  type        = list(string)
  default     = ["SecurityGroup"]
}

variable "manage_redirect_uris" {
  description = "Whether to create the azuread_application_redirect_uris resource at all. A plain bool the caller controls directly, not derived from whether redirect_uris is non-empty."
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
}
