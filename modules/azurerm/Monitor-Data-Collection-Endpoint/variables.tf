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

variable "data_collection_endpoint_name" {
  description = "Name of the data collection endpoint"
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

variable "public_network_access_enabled" {
  default     = true
  description = "Whether network access from public internet to the Data Collection Endpoint are allowed"
  type        = bool
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
