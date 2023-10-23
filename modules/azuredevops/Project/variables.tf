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

variable "project" {}

variable "name" {}

variable "description" {}

variable "visibility" {
  default = "private"
}

variable "version_control" {
  default = "git"
}

variable "work_item_template" {
  default = "Agile"
}

variable "features" {
  default = {
    "testplans"       = "disabled"
    "artifacts"       = "enabled"
    "repositories"    = "disabled"
    "pipelines"       = "enabled"
    "boards"          = "disabled"
  }
}
