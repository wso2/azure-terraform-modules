# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Bastion VM"
}

variable "environment" {
  type        = string
  description = "The environment"
}

variable "project" {
  type        = string
  description = "The project"
}

variable "application_name" {
  type        = string
  description = "The name of the Bastion VM. Changing this forces a new resource to be created"
}

variable "padding" {
  type        = string
  description = "The padding"
}

variable "shortened_project" {
  description = "The shortened project name"
  type        = string
}

variable "shortened_environment" {
  description = "Shortened name for environment of the project in which this resource is deployed"
  type        = string
}

variable "shortened_location" {
  description = "Shortened name for the Azure location where the resource exists"
  type        = string
}

variable "shortened_padding" {
  description = "Shortened padding for the resource name"
  type        = string
}

variable "shortened_application_name" {
  description = "The shortened name of the Bastion VM."
  type        = string
  default     = "bastion"
}

variable "virtual_network_name" {
  type        = string
  description = "The Virtual Network name where the subnet of Bastion needs to be created"
}

variable "subnet_address_prefix" {
  type        = string
  description = "The subnet address space"
}

variable "source_image_id" {
  type        = string
  description = "The ID of the Image which this Virtual Machine should be created from"
}

variable "size" {
  type        = string
  description = "The SKU which should be used for this Virtual Machine"
}

variable "os_disk_size_gb" {
  type        = string
  description = "The Size of the Internal OS Disk in GB"
}

variable "managed_disk_size_gb" {
  type        = string
  description = "Specifies the size of the managed disk to create in gigabytes"

}

variable "admin_username" {
  type        = string
  description = "The username of the local administrator used for the Virtual Machine"
}

variable "public_key_path" {
  type        = string
  description = "The path of the Public Key which should be used for authentication"
}

variable "default_tags" {
  type        = map(string)
  description = "The default tags"
}

variable "firewall_private_ip" {
  type        = string
  description = "Private IP address of Firewall"
}

variable "enable_ama_agent" {
  type        = bool
  description = "Specifies to enable Azure Monitoring Agent"
  default     = false
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account"
  type        = string
  default     = "LRS"
}

variable "default_action" {
  description = "The default action of allow or deny when no other rules match"
  type        = string
  default     = "Deny"
}

variable "delete_retention_days_policy" {
  description = "The number of days that the blob should be retained, between 1 and 365 days"
  type        = number
  default     = 7
}

variable "access_tier" {
  description = "The access tier for BlobStorage accounts"
  type        = string
  default     = "Hot"
}

variable "storage_account_network_rules_ip_rules" {
  description = "List of public IP or IP ranges in CIDR Format"
  type        = list(string)
  default     = []
}

variable "allow_nested_items_to_be_public" {
  description = "Allow or disallow nested items within this Account to opt into being public"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Whether the public network access is enabled?"
  type        = bool
  default     = true
}

variable "private_endpoint_subnet_id" {
  description = "Subnet resource ID of the Private endpoint subnet"
  type        = string
}

variable "private_dns_zone_ids" {
  description = "List of Private DNS Zone IDs to add to the Private DNS Zone Group of the Storage Account"
  type        = list(string)
}
