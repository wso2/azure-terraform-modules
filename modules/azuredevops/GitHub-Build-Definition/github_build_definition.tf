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

resource "azuredevops_build_definition" "devops_build_definition" {
  project_id      = var.project_id
  name            = var.build_definition_name
  agent_pool_name = var.agent_pool_name
  path            = var.pipeline_path
  queue_status    = var.status

  ci_trigger {
    use_yaml = true
  }

  repository {
    repo_id               = join("/", [var.github_org_name, var.github_repo_name])
    repo_type             = var.repo_type
    yml_path              = var.yml_path
    branch_name           = var.branch_name
    service_connection_id = var.github_service_connection_id
  }
}
