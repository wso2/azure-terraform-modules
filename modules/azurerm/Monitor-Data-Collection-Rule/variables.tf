# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 LLC (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "project" {
  description = "Name of the project"
  type        = string
}

variable "rule_name" {
  description = "Name of the data collection rule"
  type        = string
}

variable "environment" {
  description = "Name of the environment"
  type        = string
}

variable "location" {
  description = "Name of the location"
  type        = string
}

variable "padding" {
  description = "Padding"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "data_flow_destinations" {
  description = "Specifies a list of destination names"
  type        = list(string)
}

variable "data_flow_streams" {
  description = "Specifies a list of streams"
  type        = list(string)
}

variable "destination_la_name" {
  description = "The name which should be used for this destination"
  type        = string
}

variable "destination_la_workspace_resource_id" {
  description = "The ID of a Log Analytic Workspace resource"
  type        = string
}

variable "data_sources_syslog_name" {
  description = "The name which should be used for this data source"
  type        = string
  default     = null
}

variable "data_sources_syslog_facility_names" {
  description = "Specifies a list of facility names"
  type        = list(string)
  default     = null
}

variable "data_sources_syslog_log_levels" {
  description = "Specifies a list of log levels"
  type        = list(string)
  default     = null
}

variable "kind" {
  description = "The kind of the Data Collection Endpoint. Possible values are Linux and Windows"
  default     = "Linux"
  type        = string
}

variable "default_tags" {
  description = "A mapping of tags which should be assigned to the Data Collection Endpoint"
}

variable "data_collection_endpoint_id" {
  description = "The ID of the Data Collection Endpoint"
  type        = string
}

variable "data_flow_transform_kql" {
  description = "The KQL query to transform stream data"
  type        = string
}

variable "data_flow_output_stream" {
  description = "The output stream of the transform. Only required if the data flow changes data to a different stream."
  type        = string
}

variable "stream_declaration_name" {
  description = "The name of the custom stream. This name should be unique across"
  type        = string
  default     = null
}

variable "stream_declaration_columns" {
  description = "The block to define the columns"
  type = list(object({
    name = string
    type = string
  }))
}
