# -------------------------------------------------------------------------------------
#
# Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "vmss_extension_peering_name" {
  description = "The name of the VMSS Extension Peering."
  type        = string
}

variable "linux_vmss_id" {
  description = "The ID of the Linux Virtual Machine Scale Set."
  type        = string
}

variable "vmss_extension_publisher" {
  description = "The publisher of the VMSS Extension."
  type        = string
}

variable "vmss_extension_type" {
  description = "The type of the VMSS Extension."
  type        = string
}

variable "vmss_extension_type_handler_version" {
  description = "The type handler version of the VMSS Extension."
  type        = string
}

variable "vmss_extension_auto_upgrade_minor_version" {
  default     = "true"
  description = "Whether the VMSS Extension should auto upgrade minor version."
  type        = bool
}

variable "vmss_extension_settings" {
  default     = ""
  description = "The settings of the VMSS Extension."
  type        = string
}

variable "vmss_extension_protected_settings" {
  default     = ""
  description = "The protected settings of the VMSS Extension."
  type        = string
}

variable "vmss_extension_create_timeout" {
  default     = "30m"
  description = "The create timeout of the VMSS Extension."
  type        = string
}

variable "vmss_extension_update_timeout" {
  default     = "30m"
  description = "The update timeout of the VMSS Extension."
  type        = string
}

variable "vmss_extension_read_timeout" {
  default     = "5m"
  description = "The read timeout of the VMSS Extension."
  type        = string
}

variable "vmss_extension_delete_timeout" {
  default     = "30m"
  description = "The delete timeout of the VMSS Extension."
  type        = string
}
