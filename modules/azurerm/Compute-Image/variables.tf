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
  type = string
  description = "Specifies the name of the Shared Image. Changing this forces a new resource to be created."
}

variable "gallery_name" {
  type = string
  description = "Specifies the name of the Shared Image Gallery in which this Shared Image should exist."
}

variable "resource_group" {
  type = string
  description = "The name of the resource group in which the Shared Image Gallery exists."
}

variable "location" {
  type = string
  description = "Specifies the supported Azure location where the Shared Image Gallery exists."
}

variable "shared_image_os_type" {
  type        = string
  default     = "Linux"
  description = "The type of Operating System present in this Shared Image. Possible values are Linux and Windows"
}

variable "hyper_v_generation" {
  type        = string
  default     = "V1"
  description = "The generation of HyperV that the Virtual Machine used to create the Shared Image is based on"
}

variable "shared_image_publisher" {
  type        = string
  default     = "WSO2"
  description = "The Publisher Name for this Gallery Image"
}

variable "shared_image_offer" {
  type        = string
  default     = "Ubuntu"
  description = "The Offer Name for this Shared Image"
}

variable "shared_image_sku" {
  type        = string
  default     = "18.04-LTS"
  description = "The Name of the SKU for this Gallery Image"
}
