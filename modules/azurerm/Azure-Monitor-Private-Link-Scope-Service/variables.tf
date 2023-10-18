# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "project" {
    type = string
    description = "The name of the project"
}

variable "environment" {
    type =  string
    description = "The name of the environment"
}
variable "location" {
    type = string
    description = "The Azure region to deploy"
}

variable "workload" {
    type =  string
    description = "Worklaod name for the resource"
}

variable "padding" {
    type = string
    description = "Padding for the deployment"
}

variable "private_link_scope_name" {
    type = string
    description = "The name of the Azure Monitor Private Link Scope. Changing this forces a new resource to be created"
}

variable "resource_group_name" {
    type = string
    description = "The name of the Resource Group where the Azure Monitor Private Link Scope should exist"
}

variable "default_tags" {
    type = map(string)
    description = "A mapping of tags which should be assigned to the Azure Monitor Private Link Scope"
}

variable "linked_resource_id" {
    type = string
    description = "The ID of the linked resource"
}
