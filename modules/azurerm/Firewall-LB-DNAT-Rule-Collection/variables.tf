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
  description = "Resource group name"
  type        = string
}

variable "firewall_name" {
  description = "Firewall name"
  type        = string
}

variable "firewall_nat_rule_collection_name" {
  description = "Firewall nat rule collection name"
  type        = string
}

variable "priority" {
  description = "Priority"
  type        = number
}

variable "dynamic_nat_rules" {
  description = "Map of nat rules"
  type = map(object({
    public_ip_name         = string
    private_ip_address     = string
    nat_rule_name_shortned = string
    fw_ip_association_name = string
    public_ip_prefix_id    = string
  }))
}
