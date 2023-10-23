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

variable "project_id" {
  description = "The ID of the project."
  type        = string
}

variable "project" {
  description = "The name of the project in which the service endpoint will be created."
  type        = string
}

variable "service_endpoint_name" {
  description = "The name you will use to refer to this service connection in task inputs."
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
