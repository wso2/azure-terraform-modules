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

variable "resource_group_name" {
  type = string
  description = "The name of the resource group in which this is created in."
}

variable "private_dns_a_record_name" {
  type = string
  description = "The name of the DNS A Record."
}

variable "private_dns_zone_name" {
  type = string
  description = "The name of the Private DNS Zone."
}

variable "default_tags" {
  type    = map(string)
  description = "Default tag list"
}

variable "records" {
  type = list(string)
  description = "List of IPv4 Addresses."
}

variable "time_to_live" {
  description = "The Time To Live (TTL) of the DNS record in seconds."
  type = string
}
