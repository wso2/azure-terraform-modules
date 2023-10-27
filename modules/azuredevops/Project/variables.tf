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

variable "project" {
  description = "The name of the project."
  type        = string
}

variable "name" {
  description = "The name of the project."
  type        = string
}

variable "description" {
  description = "The description of the project."
  type        = string
}

variable "visibility" {
  default     = "private"
  description = "Specifies the visibility of the Project. Valid values: private or public."
  type        = string
}

variable "version_control" {
  default     = "git"
  description = "Specifies the version control type of the project. Valid values: git or tfvc."
  type        = string
}

variable "work_item_template" {
  default     = "Agile"
  description = "Specifies the work item template of the project. Valid values: Agile, Scrum, or CMMI."
  type        = string
}

variable "features" {
  default = {
    "testplans"    = "disabled"
    "artifacts"    = "enabled"
    "repositories" = "disabled"
    "pipelines"    = "enabled"
    "boards"       = "disabled"
  }
  description = "Specifies the features of the project. Valid values: testplans, artifacts, repositories, pipelines, boards."
  type        = map(string)
}
