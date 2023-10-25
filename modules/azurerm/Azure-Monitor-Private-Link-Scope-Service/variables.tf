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
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The name of the environment"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy"
  type        = string
}

variable "workload" {
  description = "Worklaod name for the resource"
  type        = string
}

variable "padding" {
  description = "Padding for the deployment"
  type        = string
}

variable "private_link_scope_name" {
  description = "The name of the Azure Monitor Private Link Scope. Changing this forces a new resource to be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the Azure Monitor Private Link Scope should exist"
  type        = string
}

variable "linked_resource_id" {
  description = "The ID of the linked resource"
  type        = string
}
