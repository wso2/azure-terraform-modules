/*
 * Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com).
 *
 * WSO2 LLC. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

resource "azurerm_api_management" "api_management" {
  name                = join("-", [var.api_management_abbreviation, var.api_management_name])
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email
  min_api_version     = var.min_api_version
  tags                = var.tags
}
