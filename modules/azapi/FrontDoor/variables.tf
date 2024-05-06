# -------------------------------------------------------------------------------------
#
# Copyright (c) 2024, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
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

variable "frontdoor_name" {
  description = "The name of the Front Door."
  type        = string
}

variable "frontdoor_abbreviation" {
  description = "The abbreviation to be used in the name of the Front Door."
  type        = string
  default     = "fd"
}

variable "resource_group_id" {
  description = "The ID of the resource group in which the Front Door will be created."
  type        = string
}

variable "enabled" {
  description = "The state of the Front Door. Values are Enabled or Disabled."
  type        = string
  default     = "Enabled"
}

variable "frontend_endpoints" {
  description = "A list of frontend endpoints to be associated with the Front Door."
  type = list(object({
    name                             = string
    hostname                         = string
    sessionAffinityEnabledState      = string
    sessionAffinityTtlSeconds        = number
    webApplicationFirewallPolicyLink = string
  }))
}

variable "frontend_endpoints_abbreviation" {
  description = "The abbreviation to be used in the name of the frontend endpoints."
  type        = string
  default     = "fe"
}

variable "routing_rules" {
  description = "A list of routing rules to be associated with the Front Door. Check https://learn.microsoft.com/en-us/azure/templates/microsoft.network/frontdoors?pivots=deployment-language-terraform for more information."
  type        = any
}

variable "load_balancing_settings" {
  description = "A list of load balancing settings to be associated with the Front Door."
  type = list(object({
    name                          = string
    sampleSize                    = number
    successfulSamplesRequired     = number
    additionalLatencyMilliseconds = number
  }))
}

variable "load_balancing_abbreviation" {
  description = "The abbreviation to be used in the name of the load balancing settings."
  type        = string
  default     = "lb"
}

variable "health_probe_settings" {
  description = "A list of health probe settings to be associated with the Front Door."
  type = list(object({
    name              = string
    enabledState      = string
    path              = string
    protocol          = string
    healthProbeMethod = string
    intervalInSeconds = number
  }))
}

variable "health_probe_abbreviation" {
  description = "The abbreviation to be used in the name of the health probe settings."
  type        = string
  default     = "hp"
}

variable "backend_pools" {
  description = "A list of backend pools to be associated with the Front Door."
  type = list(object({
    name = string
    backends = list(object({
      address           = string
      backendHostHeader = string
      enabledState      = string
      httpPort          = number
      httpsPort         = number
      priority          = number
      weight            = number
    }))
    loadBalancingSettings = string
    healthProbeSettings   = string
  }))
}

variable "rules_engines" {
  description = "A list of rules engines to be associated with the Front Door. Check https://learn.microsoft.com/en-us/azure/templates/microsoft.network/frontdoors/rulesengines?pivots=deployment-language-terraform for more information."
  type = list(object({
    name  = string
    rules = any
  }))
}

variable "rules_engine_map" {
  description = "A map of rules engines to be associated with the Front Door."
  type        = map(string)
}
