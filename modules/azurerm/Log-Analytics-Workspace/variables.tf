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

variable "environment" {
  description = "value of the environment"
  type        = string
}

variable "location" {
  description = "value of the location"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Log Analytics Workspace."
  type        = string
}

variable "project" {
  description = "value of the project"
  type        = string
}

variable "application_name" {
  description = "value of the application"
  type        = string
}

variable "padding" {
  description = "value of the padding"
  type        = string
}

variable "tags" {
  description = "Tags for the Log Analytics Workspace."
  type        = map(string)
}

variable "log_analytics_workspace_sku" {
  description = "The SKU used for this Log Analytics Workspace."
  type        = string
}

variable "log_retention_in_days" {
  description = "The retention period for the logs in days."
  type        = number
}

variable "daily_quota_gb" {
  default     = -1
  description = "The daily quota for the logs in GB."
  type        = number
}

variable "internet_ingestion_enabled" {
  default     = true
  description = "Should the Log Analytics Workspace support ingestion over the Public Internet?"
  type        = bool
}

variable "internet_query_enabled" {
  default     = true
  description = "Should the Log Analytics Workspace support querying over the Public Internet"
  type        = bool
}
