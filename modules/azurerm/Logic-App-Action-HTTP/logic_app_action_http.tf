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


resource "azurerm_logic_app_action_http" "logic_app_action_http" {
  count        = local.use_custom_action ? 0 : 1
  name         = join("-", [var.abbreviation, var.name])
  logic_app_id = var.logic_app_id
  method       = var.method
  uri          = var.uri
  body         = var.body
  headers      = var.headers
  queries      = var.queries

  dynamic "run_after" {
    for_each = var.run_after

    content {
      action_name   = run_after.value.action_name
      action_result = run_after.value.action_result
    }
  }
}

resource "azurerm_logic_app_action_custom" "logic_app_action_http" {
  count        = local.use_custom_action ? 1 : 0
  name         = join("-", [var.abbreviation, var.name])
  logic_app_id = var.logic_app_id
  body = jsonencode(merge(
    {
      type     = "Http"
      runAfter = { for r in var.run_after : r.action_name => [r.action_result] }
      inputs = merge(
        {
          method = var.method
          uri    = var.uri
        },
        var.body == null ? {} : { body = try(jsondecode(var.body), var.body) },
        var.headers == null ? {} : { headers = var.headers },
        var.queries == null ? {} : { queries = var.queries },
        var.authentication == null ? {} : { authentication = var.authentication }
      )
    },
    length(var.secure_data) == 0 ? {} : { runtimeConfiguration = { secureData = { properties = var.secure_data } } }
  ))
}

moved {
  from = azurerm_logic_app_action_http.logic_app_action_http
  to   = azurerm_logic_app_action_http.logic_app_action_http[0]
}
