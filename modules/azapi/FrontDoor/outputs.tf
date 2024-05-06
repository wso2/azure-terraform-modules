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

output "frontdoor_id" {
  description = "The ID of the Front Door."
  value       = jsondecode(azapi_resource.frontdoor.output).properties.frontdoorId
}

output "frontdoor_frontend_endpoint_ids" {
  description = "The Resource IDs of the Frontend Endpoints of the Front Door. This is used to configure custom HTTPS settings."
  value       = [for endpoint in jsondecode(azapi_resource.frontdoor.output).properties.frontendEndpoints : endpoint.id if endpoint.name != "${var.frontend_endpoints_abbreviation}-default"]
}

output "frontdoor_frontend_endpoint_names" {
  description = "The Resource names of the Frontend Endpoints of the Front Door."
  value       = [for endpoint in jsondecode(azapi_resource.frontdoor.output).properties.frontendEndpoints : endpoint.name if endpoint.name != "${var.frontend_endpoints_abbreviation}-default"]
}
