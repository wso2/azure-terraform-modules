# -------------------------------------------------------------------------------------
#
# Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "name" {
  description = "Specifies the name of the LB Rule. Changing this forces a new resource to be created."
  type        = string
}

variable "loadbalancer_id" {
  description = "The ID of the Load Balancer in which to create the Rule. Changing this forces a new resource to be created."
  type        = string
}

variable "frontend_ip_configuration_name" {
  description = "The name of the frontend IP configuration to which the rule is associated."
  type        = string
}

variable "protocol" {
  description = "The transport protocol for the external endpoint. Possible values are Tcp, Udp or All."
  type        = string
  default     = "All"
}

variable "frontend_port" {
  description = "The port for the external endpoint. Port numbers for each Rule must be unique within the Load Balancer. Possible values range between 0 and 65534, inclusive."
  type        = number
}

variable "backend_port" {
  description = "The port used for internal connections on the endpoint. Possible values range between 0 and 65535, inclusive."
  type        = number
}

variable "backend_address_pool_ids" {
  description = "A list of reference to a Backend Address Pool over which this Load Balancing Rule operates."
  type        = list(string)
  default     = []
}
