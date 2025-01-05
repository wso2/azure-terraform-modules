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

variable "monitor_private_link_scope_name" {
  description = "The name of the Azure Monitor Private Link Scope"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the Azure Monitor Private Link Scope should exist"
  type        = string
}

variable "tags" {
  description = "A mapping of tags which should be assigned to the Azure Monitor Private Link Scope"
  type        = map(string)
}

variable "monitor_private_link_scope_abbreviation" {
  description = "The abbreviation to be used."
  type        = string
  default     = "ampls"
}

variable "ingestion_access_mode" {
  description = "The access mode for the Azure Monitor Private Link Scope"
  type        = string
  default     = "PrivateOnly"
}
