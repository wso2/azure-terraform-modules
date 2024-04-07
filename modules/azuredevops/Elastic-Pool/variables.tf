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

variable "pool_name" {
  description = "The name of the elastic pool."
  type        = string
}

variable "service_endpoint_id" {
  description = "The ID of the service endpoint."
  type        = string
}
variable "service_endpoint_scope" {
  description = "The scope of the service endpoint."
  type        = string
}

variable "desired_idle" {
  description = "Number of agents to keep on standby."
  type        = number
}

variable "max_capacity" {
  description = "Maximum number of virtual machines in the scale set"
  type        = number
}

variable "project_id" {
  description = "The ID of the project where a new Elastic Pool will be created."
  default     = null
  type        = string
}

variable "vmss_resource_id" {
  description = "The ID of the VMSS resource."
  type        = string
}

variable "recycle_after_each_use" {
  description = "Tear down virtual machines after every use."
  default     = false
  type        = bool
}

variable "time_to_live_minutes" {
  description = "Delay in minutes before deleting excess idle agents."
  default     = 30
  type        = number
}

variable "agent_interactive_ui" {
  description = "Set whether agents should be configured to run with interactive UI."
  default     = false
  type        = bool
}

variable "auto_provision" {
  description = "Specifies whether a queue should be automatically provisioned for each project collection."
  default     = false
  type        = bool
}

variable "auto_update" {
  description = "Specifies whether or not agents within the pool should be automatically updated."
  default     = true
  type        = bool
}
