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

variable "eventhub_name" {
  description = "The name of the eventhub."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group to deploy the dashboard in."
  type        = string
}

variable "namespace_name" {
  description = "The name of the namespace."
  type        = string
}

variable "partition_count" {
  description = "The number of partitions."
  type        = number
}

variable "message_retention" {
  description = "The number of days to retain the events for."
  type        = number
}
