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

variable "target_resource_set" {
  description = "Resource set to enable Azure Defender for. Possible options are 'AppServices', 'ContainerRegistry', 'KeyVaults', 'KubernetesService', 'SqlServers', 'SqlServerVirtualMachines', 'StorageAccounts', 'VirtualMachines', 'Arm' and 'Dns'"
  type        = string
}

variable "pricing_setting" {
  default     = "Free"
  description = "Pricing option for target resource set. Possible values are 'Free' and 'Standard'"
  type        = string
}

variable "subplan" {
  description = "Resource type pricing subplan. Contact your MSFT representative for possible values."
  type        = string
  default     = ""
}

variable "extensions" {
  default     = []
  description = "List of extensions to enable for the target resource set"
  type = list(object({
    name                            = string
    additional_extension_properties = map(string)
  }))
}
