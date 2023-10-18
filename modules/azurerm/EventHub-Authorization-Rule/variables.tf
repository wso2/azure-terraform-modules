# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "project" {
  description = "The project name"
  type        = string
}

variable "application_name" {
  description = "Application name for the resource"
  type        = string
}

variable "workload_name" {
  description = "Workload name for the resource"
  type        = string
}

variable "environment" {
  description = "The environment of the project in which this resource is deployed"
  type        = string
}

variable "location" {
  description = "Azure location where the resource exists"
  type        = string
}

variable "padding" {
  description = "Padding for the resource name"
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
  description = "Does this Authorization Rule have permissions to Listen to the Event Hub?"
  type        = bool
  default     = false
}

variable "send" {
  description = "Does this Authorization Rule have permissions to Send to the Event Hub?"
  type        = bool
  default     = false
}

variable "manage" {
  description = "Does this Authorization Rule have permissions to Manage to the Event Hub?"
  type        = bool
  default     = false
}
