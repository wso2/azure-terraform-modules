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

variable "nsg_name" {
  description = "Name of the Network Security group which will contain the Rule"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource group which contains"
  type        = string
}

variable "network_security_rule_name" {
  description = "Name of the Network Security Rule"
  type        = string
}

variable "priority" {
  description = "Priority of the rule"
  type        = number
}

variable "direction" {
  description = "Direction of traffic controlled. Must be Inbound or Outbound"
  type        = string
}

variable "access" {
  description = "Allow or Deny Traffic"
  type        = string
}

variable "protocol" {
  description = "Allow or Deny Traffic"
  type        = string
}

variable "source_port_range" {
  default     = null
  description = "Source port for considered traffic"
  type        = string
}

variable "destination_port_range" {
  default     = null
  description = "Destination port for considered traffic"
  type        = string
}

variable "source_port_ranges" {
  default     = null
  description = "List of source ports for considered traffic"
  type        = list(string)
}

variable "destination_port_ranges" {
  default     = null
  description = "List of destination ports for considered traffic"
  type        = list(string)
}

variable "source_address_prefix" {
  default     = null
  description = "Source Address range for considered traffic"
  type        = string
}

variable "destination_address_prefix" {
  default     = null
  description = "Destination Address range for considered traffic"
  type        = string
}

variable "destination_address_prefixes" {
  default     = null
  description = "List destination address ranges for considered traffic"
  type        = list(string)
}

variable "source_address_prefixes" {
  default     = null
  description = "List source address range for considered traffic"
  type        = list(string)
}

variable "source_application_security_group_ids" {
  default     = null
  description = "List of source application security group ids"
  type        = list(string)
}
