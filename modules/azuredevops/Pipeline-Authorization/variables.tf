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

variable "project_id" {
  description = "The ID of the project"
  type        = string
}

variable "resource_id" {
  description = "The ID of the resource"
  type        = string
}

variable "pipeline_id" {
  description = "The ID of the pipeline. If not configured, all pipelines will be authorized. Changing this forces a new resource to be created."
  default     = null
  type        = string
}

variable "authorized_type" {
  description = "The type of the resource. Valid values: endpoint, queue, variablegroup, environment, repository"
  type        = string
}
