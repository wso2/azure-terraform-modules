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

output "elastic_pool_id" {
  description = "The ID of the elastic pool."
  depends_on  = [azuredevops_elastic_pool.elastic_pool]
  value       = azuredevops_elastic_pool.elastic_pool.id
}

output "elastic_pool_name" {
  description = "The Name of the elastic pool"
  depends_on  = [azuredevops_elastic_pool.elastic_pool]
  value       = azuredevops_elastic_pool.elastic_pool.name
}
