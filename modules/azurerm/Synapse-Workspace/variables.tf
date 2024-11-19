# -------------------------------------------------------------------------------------
#
# Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------


variable "name" {
  description = "The name of the Synapse Workspace"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Synapse Workspace"
  type        = string
}

variable "location" {
  description = "The Azure location where the Synapse Workspace should be created"
  type        = string
}

variable "storage_data_lake_gen2_filesystem_id" {
  description = "The ID of the Data Lake Storage Gen2 Filesystem to be used by the Synapse Workspace"
  type        = string
}

variable "sql_administrator_login" {
  description = "The username of the SQL Administrator"
  type        = string
}

variable "sql_administrator_login_password" {
  description = "The password of the SQL Administrator"
  type        = string
  sensitive   = true
}

variable "managed_virtual_network_enabled" {
  description = "Enable or disable Managed Virtual Network for the Synapse Workspace"
  type        = bool
  default     = true
}

variable "data_exfiltration_protection_enabled" {
  description = "Enable or disable data exfiltration protection"
  type        = bool
  default     = true
}

variable "purview_id" {
  description = "The ID of the Purview account to be associated with the Synapse Workspace"
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
