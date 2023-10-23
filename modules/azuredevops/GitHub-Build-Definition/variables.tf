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

variable "project_id" {}
variable "project" {}
variable "definition_name" {}
variable "github_service_connection_id" {}
variable "github_org_name" {}
variable "github_repo_name" {}
variable "yml_path" {}
variable "branch_name" {}
variable "agent_pool_name" {
  default = "Azure Pipelines"
}
variable "pipeline_path" {
  default = "\\"
}
