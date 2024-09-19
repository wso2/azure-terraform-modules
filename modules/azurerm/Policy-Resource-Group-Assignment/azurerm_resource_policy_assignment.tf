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

resource "azurerm_resource_group_policy_assignment" "resource_group_policy_assignment" {
  name                 = var.name
  resource_group_id    = var.resource_group_resource_id
  policy_definition_id = var.policy_definition_id
  description          = var.description
  display_name         = var.display_name
  enforce              = var.enforce

  dynamic "identity" {
    for_each = var.identity_type != null ? [1] : []
    content {
      type         = var.identity_type
      identity_ids = var.identity_ids
    }
  }

  dynamic "non_compliance_message" {
    for_each = var.non_compliance_message
    content {
      content                        = non_compliance_message.value["content"]
      policy_definition_reference_id = non_compliance_message.value["policy_definition_reference_id"]
    }
  }

  parameters = var.parameters
  location   = var.location
}
