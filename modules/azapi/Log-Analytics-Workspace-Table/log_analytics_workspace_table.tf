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

resource "azapi_resource" "log_analytics_workspace_table" {
  type      = "Microsoft.OperationalInsights/workspaces/tables@2022-10-01"
  name      = var.resource_name
  parent_id = var.log_analytics_workspace_id
  body = jsonencode({
    properties = {
      plan            = var.ingestion_plan
      retentionInDays = var.retention_in_days
      schema = {
        columns = var.columns
        name    = var.table_name
      }
      totalRetentionInDays = var.total_retention_in_days
    }
  })
}
