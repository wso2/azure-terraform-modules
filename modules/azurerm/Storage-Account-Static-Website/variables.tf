# -------------------------------------------------------------------------------------
#
# Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "shortened_project" {}
variable "application_name" {}
variable "shortened_environment" {}
variable "location" {}
variable "resource_group_name" {}
variable "account_tier" {}
variable "account_replication_type" {}
variable "storage_account_tags" {}
variable "shortened_location" {}
variable "shortened_padding" {}
variable "index_document" {}
variable "error_document" {}
variable "network_rules_ip_whitelist" {
    default = []
}
variable "network_rules_default_action" {
    default = "Allow"
}
variable "network_rules_subnet_ids" {
    default = []
}

variable "allow_nested_items_to_be_public" {
  description = "Allow or disallow nested items within this Account to opt into being public"
  type        = bool
  default     = false
}
