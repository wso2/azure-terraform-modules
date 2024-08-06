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

variable "function_app_name" {
  description = "The name of the Function App."
  type        = string
}

variable "location" {
  description = "The location of the resource need to be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the vm is created in."
  type        = string
}

variable "app_service_plan_id" {
  description = "The ID of the App Service Plan within which to create this Function App."
  type        = string
}

variable "os_type" {
  description = "A string indicating the Operating System type for this function app."
  type        = string
}

variable "storage_account_access_key" {
  description = "The access key which will be used to access the backend storage account for the Function App."
  type        = string
}

variable "storage_account_name" {
  description = "The backend storage account name which will be used by this Function App (such as the dashboard, logs)."
  type        = string
}

variable "app_settings" {
  description = "A map of key-value pairs for App Settings and custom values."
  type        = map(string)
}

variable "app_runtime_version" {
  description = "The runtime version associated with the Function App. Defaults to ~1."
  type        = string
}

variable "client_cert_mode" {
  default     = "Optional"
  description = "The mode of the Function App's client certificates requirement for incoming requests. Possible values are Required and Optional."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet the app service will be associated to (the subnet must have a service_delegation configured for Microsoft.Web/serverFarms)."
  type        = string
}

variable "linux_fx_version" {
  description = "Linux App Framework and version for the AppService, e.g. DOCKER|(golang:latest)."
  type        = string
}

variable "use_32_bit_worker_process" {
  default     = false
  description = "Should the Function App run in 32 bit mode, rather than 64 bit mode? Defaults to true."
  type        = bool
}

variable "managed_identity_type" {
  default     = "SystemAssigned"
  description = "Specifies the identity type of the Function App. Possible values are SystemAssigned, UserAssigned"
  type        = string
}

variable "always_on" {
  default     = false
  description = "Should the Function App be loaded at all times? Defaults to false."
  type        = bool
}

variable "health_check_path" {
  default     = null
  description = "Path which will be checked for this function app health."
  type        = string
}

variable "ftps_state" {
  default     = "AllAllowed"
  description = "State of FTP / FTPS service for this function app. Possible values include: AllAllowed, FtpsOnly and Disabled. Defaults to AllAllowed."
  type        = string
}

variable "tags" {
  description = "Default tag list"
  type        = map(string)
}

variable "https_only" {
  default     = true
  description = "Should the Function App only be accessible over HTTPS? Defaults to true."
  type        = bool
}
