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

variable "linux_function_app_name" {
  description = "Name of the function app."
  type        = string
}

variable "location" {
  description = "Region to deploy Azure function app."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name to deploy Azure function app in."
  type        = string
}

variable "storage_account_name" {
  description = "Storage account name which is used to host the function app."
  type        = string
}

variable "storage_account_access_key" {
  description = "Access key of the storage account created to host the function app."
  type        = string
}

variable "application_insights_key" {
  default     = null
  description = "Application insight key to integrate Application Insight"
  type        = string
}

variable "application_insights_connection_string" {
  default     = null
  description = "Application insight connection string to integrate Application Insight"
  type        = string
}

variable "service_plan_id" {
  description = "Service plan ID of the function app."
  type        = string
}

variable "function_app_subnet_id" {
  default     = null
  description = "ID of the subnet where function app will be created in."
  type        = string
}

variable "is_function_app_always_on" {
  default     = true
  description = "Whether the function app is always on or not."
  type        = bool
}

variable "is_route_all" {
  default     = true
  description = "Whether Route All enabled or not."
  type        = bool
}

variable "worker_count" {
  description = "Number of workers to the function app."
  type        = number
}

variable "app_settings" {
  default     = null
  description = "A map of key-value pairs for App Settings and custom values."
  type        = map(string)
}

variable "java_version" {
  type        = number
  description = "Java version to be used in the function app."
  default     = null
}

variable "dotnet_version" {
  default     = null
  description = ".NET version to be used in the function app."
  type        = number
}

variable "managed_identity_type" {
  default     = "SystemAssigned"
  description = "Specifies the identity type of the Function App. Possible values are SystemAssigned, UserAssigned"
  type        = string
}

variable "node_version" {
  default     = null
  description = "Node version to be used in the function app."
  type        = number
}

variable "python_version" {
  default     = null
  description = "Python version to be used in the function app."
  type        = number
}

variable "powershell_core_version" {
  default     = null
  description = "Java version to be used in the function app."
  type        = number
}

variable "access_restriction_ip_address" {
  default     = []
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
}

variable "access_restriction_service_tag" {
  default     = []
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
}

variable "access_restriction_vnet" {
  default     = []
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
}

variable "tags" {
  description = "Tags used for the resource."
  type        = map(string)
}
