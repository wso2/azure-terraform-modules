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

output "origin_group_id" {
  depends_on = [azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_group]
  value      = azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_group.id
}

output "origin_group_name" {
  depends_on = [azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_group]
  value      = azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_group.name
}

output "public_origin_ids" {
  depends_on = [azurerm_cdn_frontdoor_origin.cdn_frontdoor_public_origin]
  value      = { for origin in keys(var.public_origins) : origin => azurerm_cdn_frontdoor_origin.cdn_frontdoor_public_origin[origin].id }
}

output "private_link_origin_ids" {
  depends_on = [azurerm_cdn_frontdoor_origin.cdn_frontdoor_private_link_origin]
  value      = { for origin in keys(var.private_link_origins) : origin => azurerm_cdn_frontdoor_origin.cdn_frontdoor_private_link_origin[origin].id }
}

output "private_link_service_origin_ids" {
  depends_on = [azurerm_cdn_frontdoor_origin.cdn_frontdoor_private_link_service_origin]
  value      = { for origin in keys(var.private_link_service_origins) : origin => azurerm_cdn_frontdoor_origin.cdn_frontdoor_private_link_service_origin[origin].id }
}
