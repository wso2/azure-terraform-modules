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

variable "project" {
  description = "The project in which this resource is deployed"
  type        = string
}

variable "environment" {
  description = "The environment of the project in which this resource is deployed"
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group where the Event Grid System Topic should exist. Changing this forces a new Event Grid System Topic to be created."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the Event Grid System Topic should exist. Changing this forces a new Event Grid System Topic to be created."
  type        = string
}

variable "tags" {
  description = "Tags associated with this resource."
  type        = map(string)
}

variable "padding" {
  description = "Padding for this resource"
  type        = string
}

variable "application_name" {
  description = "The application name which should be used for this Event Grid System Topic"
  type        = string
}

variable "source_arm_resource_id" {
  description = "(Required) The ID of the Event Grid System Topic ARM Source. Changing this forces a new Event Grid System Topic to be created."
  type        = string
}

variable "topic_type" {
  description = "(Required) The Topic Type of the Event Grid System Topic. Changing this forces a new Event Grid System Topic to be created."
  type        = string
}
