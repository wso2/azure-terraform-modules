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

variable "data_collection_rule_name" {
  description = "Name of the data collection rule"
  type        = string
}

variable "location" {
  description = "Name of the location"
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
  default     = null
  description = "The name which should be used for this data source"
  type        = string
}

variable "data_sources_syslog_facility_names" {
  default     = null
  description = "Specifies a list of facility names"
  type        = list(string)
}

variable "data_sources_syslog_log_levels" {
  default     = null
  description = "Specifies a list of log levels"
  type        = list(string)
}

variable "kind" {
  default     = "Linux"
  description = "The kind of the Data Collection Endpoint. Possible values are Linux and Windows"
  type        = string
}

variable "tags" {
  description = "A mapping of tags which should be assigned to the Data Collection Endpoint"
  type        = map(string)
}

variable "data_collection_endpoint_id" {
  default     = null
  description = "The ID of the Data Collection Endpoint"
  type        = string
}

variable "data_flow_transform_kql" {
  default     = null
  description = "The KQL query to transform stream data"
  type        = string
}

variable "data_flow_output_stream" {
  default     = null
  description = "The output stream of the transform. Only required if the data flow changes data to a different stream."
  type        = string
}

variable "stream_declaration_name" {
  default     = null
  description = "The name of the custom stream. This name should be unique across"
  type        = string
}

variable "stream_declaration_columns" {
  default     = []
  description = "The block to define the columns"
  type = list(object({
    name = string
    type = string
  }))
}
