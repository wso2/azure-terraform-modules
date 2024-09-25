# -------------------------------------------------------------------------------------
#
# Copyright (c) 2023, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "mssql_server_id" {
  description = "The ID of the SQL Server to which this policy belongs"
  type        = string
}

variable "mssql_storage_account_primary_blob_endpoint" {
  description = "The primary blob endpoint for the storage account"
  type        = string
}

variable "mssql_storage_account_primary_access_key" {
  description = "The primary access key for the storage account"
  type        = string
}

variable "retention_in_days" {
  default     = 30
  description = "The number of days to retain audit logs for"
  type        = number
}

variable "log_monitoring_enabled" {
  default     = false
  description = "Enable audit events to Azure Monitor"
  type        = bool
}

variable "mssql_master_database_auditing_policy_enabled" {
  default     = false
  description = "Enable auditing on the master database"
  type        = bool
}
