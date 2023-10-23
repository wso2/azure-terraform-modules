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
}
variable "environment" {
  description = "The environment of the project in which this resource is deployed"
}
variable "resource_group_name" {
  description = "(Required) The name of the Resource Group where the Event Subscription should exist. Changing this forces a new Event Subscription to be created."
}
variable "location" {
  description = "(Required) The Azure Region where the Event Subscription should exist. Changing this forces a new Event Subscription to be created."
}
variable "padding" {
  description = "Padding for this resource"
}
variable "application_name" {
  description = "(Required)The application name which should be used for this Event Subscription. Changing this forces a newEvent Subscription to be created."
}
variable "event_delivery_schema" {
  description = "(Optional) Specifies the event delivery schema for the event subscription."
  default     = "EventGridSchema"
}
variable "system_topic" {
  description = "(Required) The System Topic where the Event Subscription should be created in. Changing this forces a new Event Subscription to be created."
}
variable "included_event_types" {
  description = "(Optional) A list of applicable event types that need to be part of the event subscription."
  type        = list(string)
}
variable "webhook_endpoint_url" {
  description = " (Required) Specifies the url of the webhook where the Event Subscription will receive events."
}
variable "webhook_max_events_per_batch" {
  default = 1
  description = "Maximum number of events per batch."
}
variable "webhook_max_preferred_batch_size_in_kilobytes" {
  default = 64
  description = " Preferred batch size in Kilobytes."
}
variable "retry_policy_max_delivery_attempts" {
  default     = 30
  description = "(Required) Specifies the maximum number of delivery retry attempts for events."
}
variable "event_time_to_live" {
  default     = 1440
  description = "(Required) Specifies the time to live (in minutes) for events. Supported range is 1 to 1440."
}
