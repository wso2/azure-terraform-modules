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
variable "mssql_server_id" {}
variable "mssql_storage_account_primary_blob_endpoint" {}
variable "mssql_storage_account_primary_access_key" {}
variable "retention_in_days" {
  default = 30
}

variable "log_monitoring_enabled" {
  default     = false
  type        = bool
  description = "Enable audit events to Azure Monitor"
}
