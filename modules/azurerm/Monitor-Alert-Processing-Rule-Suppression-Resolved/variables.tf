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

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "monitor_alert_processing_rule_suppression_name" {
  description = "Name of the Monitor Alert Processing Rule Suppression"
  type        = string
}

variable "tags" {
  description = "Tags for the Resource"
  type        = map(string)
}

variable "scopes" {
  description = "The scopes to apply the suppression to"
  type        = list(string)
}

variable "description" {
  description = "Description of the Monitor Alert Processing Rule Suppression"
  type        = string
}

variable "enabled" {
  description = "Is the Monitor Alert Processing Rule Suppression Enabled?"
  type        = bool
  default     = true
}

variable "operator" {
  description = "Operator for the Monitor Alert Processing Rule Suppression"
  type        = string
  default     = "Equals"
}

variable "values" {
  description = "Values for the Monitor Alert Processing Rule Suppression"
  type        = list(string)
  default     = ["Resolved"]
}
