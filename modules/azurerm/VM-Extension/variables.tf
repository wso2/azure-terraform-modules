# -------------------------------------------------------------------------------------
#
# Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "vm_extension_peering_name" {}
variable "linux_virtual_machine_id" {}
variable "vm_extension_publisher" {}
variable "vm_extension_type" {}
variable "vm_extension_type_handler_version" {}
variable "vm_extension_auto_upgrade_minor_version" { default = "true" }
variable "vm_extension_settings" { default = "" }
variable "vm_extension_protected_settings" { default = "" }
variable "vm_extension_tags" {}
variable "vm_extension_create_timeout" { default = "30m" }
variable "vm_extension_update_timeout" { default = "30m" }
variable "vm_extension_read_timeout" { default = "5m" }
variable "vm_extension_delete_timeout" { default = "30m" }
