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

variable "name" {
  description = "The name of the Azure Frontdoor"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the File Share."
  type        = string
}

variable "tags" {
  description = "The tags to associate with the resource"
  type        = map(string)
}

variable "load_balancer_enabled" {
  default     = true
  description = "Enable the Front Door Load Balancer"
  type        = bool
}

variable "routing_rules" {
  default = [
    { forwarding_configuration = [
      {
        default = "default"
      }
      ]
    }
  ]
  description = "Routing rule based on either forwarding or redirect configuration. Note that when creating a routing rule with forwarding configuration, pass the redirect configuration as an empty list (i.e redirect configuration = []) and vice versa"
  type        = any
}

variable "backend_pool_load_balancing" {
  default     = []
  description = "Backend Pool Load Balancing"
  type = list(object({
    name                            = string
    sample_size                     = number
    successful_samples_required     = number
    additional_latency_milliseconds = number
  }))
}

variable "backend_pool_health_probes" {
  default = [
    {
      default = "default"
    }
  ]
  description = "Backend Pool Health Probes"
  type        = any
}

variable "backend_pools" {
  default = [
    {
      default = "default",
      backend = [
        {
          default = "default"
        }
      ]
    }
  ]
  description = "Backend pools and Backend"
  type        = any
}

variable "frontend_endpoints" {
  default = [
    {
      default = "default"
    }
  ]
  description = "Frontend Endpoints"
  type        = any
}
