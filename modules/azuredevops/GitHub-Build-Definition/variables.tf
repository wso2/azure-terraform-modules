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

variable "build_definition_name" {
  description = "The name of the build definition."
  type        = string
}

variable "project_id" {
  description = "The ID of the project."
  type        = string
}

variable "github_service_connection_id" {
  description = "The ID of the GitHub service connection."
  type        = string
}

variable "github_org_name" {
  description = "The name of the GitHub organization."
  type        = string
}

variable "github_repo_name" {
  description = "The name of the GitHub repository."
  type        = string
}

variable "yml_path" {
  description = "The path to the YAML file."
  type        = string
}

variable "branch_name" {
  description = "The name of the branch."
  type        = string
}

variable "agent_pool_name" {
  default     = "Azure Pipelines"
  description = "The name of the agent pool."
  type        = string
}

variable "pipeline_path" {
  default     = "\\"
  description = "The path to the pipeline."
  type        = string
}

variable "repo_type" {
  default     = "GitHub"
  description = "The type of the repository."
  type        = string
}

variable "status" {
  default     = "enabled"
  description = "The queue status of the build definition. Valid values: enabled or paused or disabled"
  type        = string
}
