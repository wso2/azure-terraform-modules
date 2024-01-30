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

variable "service_endpoint_name" {
  description = "The service endpoint name."
  type        = string
}

variable "project_id" {
  description = "The ID of the project."
  type        = string
}

variable "description" {
  description = "The description of the service endpoint."
  type        = string
}

variable "github_pat" {
  description = "The GitHub personal access token."
  type        = string
}
