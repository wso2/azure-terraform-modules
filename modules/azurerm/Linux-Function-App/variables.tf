# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 LLC. (https://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "project" {
  type        = string
  description = "Name of the project in which these resources are created."
}

variable "environment" {
  type        = string
  description = "Name of the environment for the resource."
}

variable "padding" {
  type        = string
  description = "Padding used for naming conventions."
}

variable "location" {
  type        = string
  description = "Region to deploy Azure function app."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name to deploy Azure function app in."
}

variable "application_name" {
  type        = string
  description = "Application name for the function app."
}

variable "storage_account_name" {
  type        = string
  description = "Storage account name which is used to host the function app."
}

variable "storage_account_access_key" {
  type        = string
  description = "Access key of the storage account created to host the function app."
}

variable "application_insights_key" {
  type        = string
  description = "Application insight key to integrate Application Insight"
  default     = null
}

variable "application_insights_connection_string" {
  type        = string
  description = "Application insight connection string to integrate Application Insight"
  default     = null
}

variable "service_plan_id" {
  type        = string
  description = "Service plan ID of the function app."
}

variable "function_app_subnet_id" {
  type        = string
  description = "ID of the subnet where function app will be created in."
}

variable "is_function_app_always_on" {
  type        = bool
  description = "Whether the function app is always on or not."
  default     = true
}

variable "is_route_all" {
  type        = bool
  description = "Whether Route All enabled or not."
  default     = true
}

variable "worker_count" {
  type        = number
  description = "Number of workers to the function app."
}

variable "app_settings" {
  type        = map(string)
  description = "A map of key-value pairs for App Settings and custom values."
  default     = null
}

variable "java_version" {
  type        = number
  description = "Java version to be used in the function app."
  default     = null
}

variable "dotnet_version" {
  type        = number
  description = ".NET version to be used in the function app."
  default     = null
}

variable "managed_identity_type" {
  type        = string
  description = "Specifies the identity type of the Function App. Possible values are SystemAssigned, UserAssigned"
  default     = "SystemAssigned"
}

variable "node_version" {
  type        = number
  description = "Node version to be used in the function app."
  default     = null
}

variable "python_version" {
  type        = number
  description = "Python version to be used in the function app."
  default     = null
}

variable "powershell_core_version" {
  type        = number
  description = "Java version to be used in the function app."
  default     = null
}

variable "access_restriction_ip_address" {
  description = "Access restriction for function app using IP address."
  type = list(object({
    priority   = number,
    name       = string,
    ip_address = string,
    action     = string,
    headers = object({
      x_azure_fdid      = list(string),
      x_fd_health_probe = list(string),
      x_forwarded_for   = list(string),
      x_forwarded_host  = list(string)
    })
  }))
  default = []
}

variable "access_restriction_service_tag" {
  description = "Access restriction for function app using service tags."
  type = list(object({
    priority    = number,
    name        = string,
    service_tag = string,
    action      = string,
    headers = object({
      x_azure_fdid      = list(string),
      x_fd_health_probe = list(string),
      x_forwarded_for   = list(string),
      x_forwarded_host  = list(string)
    })
  }))
  default = []
}

variable "access_restriction_vnet" {
  description = "Access restriction for function app using VNet subnet."
  type = list(object({
    priority                  = number,
    name                      = string,
    virtual_network_subnet_id = string,
    action                    = string,
    headers = object({
      x_azure_fdid      = list(string),
      x_fd_health_probe = list(string),
      x_forwarded_for   = list(string),
      x_forwarded_host  = list(string)
    })
  }))
  default = []
}

variable "default_tags" {
  type        = map(string)
  description = "Tags used for the resource."
}
