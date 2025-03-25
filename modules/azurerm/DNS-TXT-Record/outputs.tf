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

output "dns_txt_record_id" {
  description = "The ID of the DNS TXT Record."
  depends_on  = [azurerm_dns_txt_record.dns_txt_record]
  value       = azurerm_dns_txt_record.dns_txt_record.id
}

output "dns_txt_record_fqdn" {
  description = "The FQDN of the DNS TXT Record."
  depends_on  = [azurerm_dns_txt_record.dns_txt_record]
  value       = azurerm_dns_txt_record.dns_txt_record.fqdn
}
