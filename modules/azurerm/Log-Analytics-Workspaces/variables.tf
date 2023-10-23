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

variable "environment" {}
variable "location" {}
variable "resource_group_name" {}
variable "project" {}
variable "application_name" {}
variable "padding" {}
variable "default_tags" {}
variable "log_analytics_workspace_sku" {}
variable "log_retention_in_days" {}
variable "daily_quota_gb" {}
variable "internet_ingestion_enabled" {
    type        = bool
    description = "Should the Log Analytics Workspace support ingestion over the Public Internet?"
    default     = true
}
variable "internet_query_enabled" {
    type        = bool
    description = "Should the Log Analytics Workspace support querying over the Public Internet"
    default     = true
}
