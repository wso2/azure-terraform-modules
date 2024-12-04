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

resource "azurerm_cdn_frontdoor_security_policy" "cdn_frontdoor_security_policy" {
  name                     = var.security_policy_name
  cdn_frontdoor_profile_id = var.cdn_frontdoor_profile_id

  security_policies {
    firewall {
      cdn_frontdoor_firewall_policy_id = var.cdn_frontdoor_firewall_policy_id

      association {
        patterns_to_match = var.patterns_to_match
        dynamic "domain" {
          for_each = var.domains
          content {
            cdn_frontdoor_domain_id = domain.value
          }
        }
      }
    }
  }
}
