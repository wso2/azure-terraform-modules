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

# Define the rules engine resource
resource "azapi_resource" "frontdoor_rules_engine" {
  count     = length(var.rules_engines)
  type      = "Microsoft.Network/frontDoors/rulesEngines@2021-06-01"
  name      = var.rules_engines[count.index].name
  parent_id = azapi_resource.frontdoor.id

  body = jsonencode({
    properties = {
      rules = var.rules_engines[count.index].rules
    }
  })

  depends_on = [
    azapi_resource.frontdoor
  ]
}

# Update the frontdoor resource with the rules engine
resource "azapi_update_resource" "frontdoor" {
  type        = "Microsoft.Network/frontDoors@2021-06-01"
  resource_id = azapi_resource.frontdoor.id
  body = jsonencode({
    properties = {
      routingRules = [
        for rule in jsondecode(azapi_resource.frontdoor.output).properties.routingRules :
        {
          id   = rule.id
          name = rule.name
          properties = {
            acceptedProtocols  = rule.properties.acceptedProtocols
            enabledState       = rule.properties.enabledState
            patternsToMatch    = rule.properties.patternsToMatch
            frontendEndpoints  = rule.properties.frontendEndpoints
            routeConfiguration = rule.properties.routeConfiguration

            rulesEngine = rule.properties.rulesEngine != null ? rule.properties.rulesEngine : contains(keys(var.rules_engine_map), rule.name) ? {
              id = "${var.resource_group_id}/providers/Microsoft.Network/frontDoors/${local.frontdoor_name}/RulesEngines/${var.rules_engine_map[rule.name]}"
            } : null
          }
        }
      ]
    }
  })

  depends_on = [
    azapi_resource.frontdoor,
    azapi_resource.frontdoor_rules_engine
  ]
}
