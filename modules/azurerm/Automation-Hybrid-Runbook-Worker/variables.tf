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

variable "resource_group_name" {
  description = "The name of the Resource Group where the Automation should exist"
  type        = string
}

variable "automation_account_name" {
  description = "The name of the automation account in which the Hybrid Worker is created"
  type        = string
}

variable "worker_group_name" {
  description = "The name of the HybridWorker Group"
  type        = string
}

variable "vm_resource_id" {
  description = "The ID of the virtual machine used for this HybridWorker"
  type        = string
}
