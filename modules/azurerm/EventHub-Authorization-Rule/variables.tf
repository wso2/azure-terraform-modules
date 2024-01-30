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

variable "eventhub_authorization_rule_name" {
  description = "Name of the EventHub Authorization Rule"
  type        = string
}

variable "eventhub_namespace_name" {
  description = "Name of the grandparent EventHub Namespace"
  type        = string
}

variable "eventhub_name" {
  description = "Name of the EventHub"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which the EventHub Namespace exists"
  type        = string
}

variable "listen" {
  default     = false
  description = "Does this Authorization Rule have permissions to Listen to the Event Hub?"
  type        = bool
}

variable "send" {
  default     = false
  description = "Does this Authorization Rule have permissions to Send to the Event Hub?"
  type        = bool
}

variable "manage" {
  default     = false
  description = "Does this Authorization Rule have permissions to Manage to the Event Hub?"
  type        = bool
}
