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
  description = "Name of the project"
  type        = string
}

variable "association_name" {
  description = "Name of the data collection rule association"
  type        = string
}

variable "environment" {
  description = "Name of the environment"
  type        = string
}

variable "data_collection_rule_id" {
  description = "The ID of the Data Collection Rule which will be associated to the target resource"
  type        = string
}

variable "target_resource_id" {
  description = "The ID of the Azure Resource which to associate to a Data Collection Rule or a Data Collection Endpoint"
  type        = string
}
