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

resource "azapi_resource" "frontdoor" {
  type      = "Microsoft.Network/frontDoors@2021-06-01"
  name      = local.frontdoor_name
  parent_id = var.resource_group_id
  location  = "Global"
  body = jsonencode({
    properties = {
      enabledState = var.enabled

      # Configure Frontend Endpoints
      frontendEndpoints = [
        for endpoint in var.frontend_endpoints :
        {
          name = join("-", [var.frontend_endpoints_abbreviation, endpoint.name])
          properties = {
            hostName                         = endpoint.hostname
            sessionAffinityEnabledState      = endpoint.sessionAffinityEnabledState
            sessionAffinityTtlSeconds        = endpoint.sessionAffinityTtlSeconds
            webApplicationFirewallPolicyLink = endpoint.webApplicationFirewallPolicyLink
          }
        }
      ]

      # Configure Routing Rules
      routingRules = [
        for rule in var.routing_rules :
        {
          name = rule.name
          properties = {
            acceptedProtocols = rule.acceptedProtocols
            enabledState      = rule.enabledState
            patternsToMatch   = rule.patternsToMatch
            frontendEndpoints = rule.frontendEndpoints != null ? [
              for frontend_endpoint in rule.frontendEndpoints :
              {
                id = "${var.resource_group_id}/providers/Microsoft.Network/frontDoors/${local.frontdoor_name}/frontendEndpoints/${join("-", [var.frontend_endpoints_abbreviation, frontend_endpoint])}"
              }
            ] : null
            routeConfiguration = rule.routeConfiguration
          }
        }
      ]

      # Configure Load Balancing Settings
      loadBalancingSettings = [
        for load_balance in var.load_balancing_settings :
        {
          name = join("-", [var.load_balancing_abbreviation, load_balance.name])
          properties = {
            sampleSize                    = load_balance.sampleSize
            successfulSamplesRequired     = load_balance.successfulSamplesRequired
            additionalLatencyMilliseconds = load_balance.additionalLatencyMilliseconds
          }
        }
      ]

      # Configure Health Probes
      healthProbeSettings = [
        for health_probe in var.health_probe_settings :
        {
          name = join("-", [var.health_probe_abbreviation, health_probe.name])
          properties = {
            enabledState      = health_probe.enabledState
            path              = health_probe.path
            protocol          = health_probe.protocol
            healthProbeMethod = health_probe.healthProbeMethod
            intervalInSeconds = health_probe.intervalInSeconds
          }
        }
      ]

      # Configure Backend Pool
      backendPools = [
        for pool in var.backend_pools :
        {
          name = pool.name
          properties = {
            backends = [
              for backend in pool.backends :
              {
                address           = backend.address
                backendHostHeader = backend.backendHostHeader
                enabledState      = backend.enabledState
                httpPort          = backend.httpPort
                httpsPort         = backend.httpsPort
                priority          = backend.priority
                weight            = backend.weight
              }
            ]
            loadBalancingSettings = pool.loadBalancingSettings != null ? {
              id = "${var.resource_group_id}/providers/Microsoft.Network/frontDoors/${local.frontdoor_name}/loadBalancingSettings/${join("-", [var.load_balancing_abbreviation, pool.loadBalancingSettings])}"
            } : null
            healthProbeSettings = pool.healthProbeSettings != null ? {
              id = "${var.resource_group_id}/providers/Microsoft.Network/frontDoors/${local.frontdoor_name}/healthProbeSettings/${join("-", [var.health_probe_abbreviation, pool.healthProbeSettings])}"
            } : null
          }
        }
      ]
    }
  })

  response_export_values = ["*"]
}
