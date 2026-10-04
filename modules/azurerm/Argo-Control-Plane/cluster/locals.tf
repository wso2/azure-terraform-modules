# -------------------------------------------------------------------------------------
#
# Copyright (c) 2026, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
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

locals {
  resource_group_name = var.create_resource_group ? azurerm_resource_group.resource_group[0].name : var.resource_group_name

  # Storage account names: <=24 chars, lowercase alphanumeric only.
  cluster_name_sanitized         = lower(replace(var.aks_cluster_name, "-", ""))
  flow_logs_storage_account_name = coalesce(var.flow_logs_storage_account_name, "${substr(local.cluster_name_sanitized, 0, 24 - length("flowlogs"))}flowlogs")
  argo_logs_storage_account_name = coalesce(var.argo_logs_storage_account_name, "${substr(local.cluster_name_sanitized, 0, 24 - length("argologs"))}argologs")

  # Key Vault names: <=24 chars, no consecutive or trailing hyphens.
  cluster_secrets_key_vault_name = coalesce(var.cluster_secrets_key_vault_name, "${trimsuffix(substr(var.aks_cluster_name, 0, 24 - length("-kms")), "-")}-kms")
  eso_key_vault_name             = coalesce(var.eso_key_vault_name, "${trimsuffix(substr(var.aks_cluster_name, 0, 24 - length("-secrets")), "-")}-secrets")
}
