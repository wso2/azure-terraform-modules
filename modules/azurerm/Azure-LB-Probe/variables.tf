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
  description = "Specifies the name of the Probe. Changing this forces a new resource to be created."
  type        = string
}

variable "loadbalancer_id" {
  description = "The ID of the LoadBalancer in which to create the NAT Rule. Changing this forces a new resource to be created."
  type        = string
}

variable "protocol" {
  description = "Specifies the protocol of the end point. Possible values are Http, Https or Tcp. If TCP is specified, a received ACK is required for the probe to be successful. If HTTP is specified, a 200 OK response from the specified URI is required for the probe to be successful."
  type        = string
  default     = "Http"
}

variable "port" {
  description = "Port on which the Probe queries the backend endpoint. Possible values range from 1 to 65535, inclusive."
  type        = number
  default     = 80
}

variable "request_path" {
  description = "The URI used for requesting health status from the backend endpoint. Required if protocol is set to Http or Https. Otherwise, it is not allowed."
  type        = string
  default     = "/"
}
