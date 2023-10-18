# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "project" {
    description = "The project name"
}
variable "environment" {
    description = "The enviroment"
}
variable "resource_group_name" {
    description = "The resource group name"
}
variable "location" {
    description = "The cloud region"
}
variable "automation_account_name" {
    description = "The azure automation account name"
}
variable "automation_account_sku_name" {
    default = "Basic"
}
variable "tags" {
    description = "The tags"
}
