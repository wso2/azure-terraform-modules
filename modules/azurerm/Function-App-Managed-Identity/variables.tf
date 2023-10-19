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
  type        = string
  description = "The name of the project. Eg: asgardeo"
}
variable "environment" {
  type        = string
  description = "The name of the environment. Eg: dev"
}
variable "location" {
  type        = string
  description = "The location of the resource need to be created."
}
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the vm is created in."
}
variable "application_name" {
  type        = string
  description = "The name of the application."
}
variable "padding" {
  type        = string
  description = "The padding value."
}
variable "app_service_plan_id" {
  type        = string
  description = "The ID of the App Service Plan within which to create this Function App."
}
variable "os_type" {
  type        = string
  description = "A string indicating the Operating System type for this function app."
}
variable "storage_account_access_key" {
  type        = string
  description = "The access key which will be used to access the backend storage account for the Function App."
}
variable "storage_account_name" {
  type        = string
  description = "The backend storage account name which will be used by this Function App (such as the dashboard, logs)."
}
variable "app_settings" {
  type        = map(string)
  description = "A map of key-value pairs for App Settings and custom values."
}
variable "app_runtime_version" {
  type        = string
  description = "The runtime version associated with the Function App. Defaults to ~1."
}
variable "client_cert_mode" {
  type        = string
  description = "The mode of the Function App's client certificates requirement for incoming requests. Possible values are Required and Optional."
  default     = "Optional"
}
variable "subnet_id" {
  type        = string
  description = "The ID of the subnet the app service will be associated to (the subnet must have a service_delegation configured for Microsoft.Web/serverFarms)."
}
variable "linux_fx_version" {
  type        = string
  description = "Linux App Framework and version for the AppService, e.g. DOCKER|(golang:latest)."
}
variable "use_32_bit_worker_process" {
  type        = bool
  description = "Should the Function App run in 32 bit mode, rather than 64 bit mode? Defaults to true."
  default     = false
}
variable "managed_identity_type" {
  type        = string
  description = "Specifies the identity type of the Function App. Possible values are SystemAssigned, UserAssigned"
  default     = "SystemAssigned"
}
variable "always_on" {
  type        = bool
  description = "Should the Function App be loaded at all times? Defaults to false."
  default     = false
}
variable "health_check_path" {
  type        = string
  description = "Path which will be checked for this function app health."
  default     = null
}
variable "ftps_state" {
  type        = string
  description = "State of FTP / FTPS service for this function app. Possible values include: AllAllowed, FtpsOnly and Disabled. Defaults to AllAllowed."
  default     = "AllAllowed"
}
variable "default_tags" {
  type        = map(string)
  description = "Default tag list"
}
