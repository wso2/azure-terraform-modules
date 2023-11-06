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

variable "location" {
  description = "Specifies the supported Azure location where the resource exists"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Bastion VM"
  type        = string
}

variable "environment" {
  description = "The environment"
  type        = string
}

variable "project" {
  description = "The project"
  type        = string
}

variable "application_name" {
  description = "The name of the Bastion VM. Changing this forces a new resource to be created"
  type        = string
}

variable "padding" {
  description = "The padding"
  type        = string
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
  default     = "bastion"
  description = "The shortened name of the Bastion VM."
  type        = string
}

variable "virtual_network_name" {
  description = "The Virtual Network name where the subnet of Bastion needs to be created"
  type        = string
}

variable "subnet_address_prefix" {
  description = "The subnet address space"
  type        = string
}

variable "source_image_id" {
  description = "The ID of the Image which this Virtual Machine should be created from"
  type        = string
}

variable "size" {
  description = "The SKU which should be used for this Virtual Machine"
  type        = string
}

variable "os_disk_size_gb" {
  description = "The Size of the Internal OS Disk in GB"
  type        = string
}

variable "managed_disk_size_gb" {
  description = "Specifies the size of the managed disk to create in gigabytes"
  type        = string
}

variable "admin_username" {
  description = "The username of the local administrator used for the Virtual Machine"
  type        = string
}

variable "public_key_path" {
  description = "The path of the Public Key which should be used for authentication"
  type        = string
}

variable "tags" {
  description = "The tags"
  type        = map(string)
}

variable "firewall_private_ip" {
  description = "Private IP address of Firewall"
  type        = string
}

variable "enable_ama_agent" {
  default     = false
  description = "Specifies to enable Azure Monitoring Agent"
  type        = bool
}

variable "account_tier" {
  default     = "Standard"
  description = "Defines the Tier to use for this storage account"
  type        = string
}

variable "account_replication_type" {
  default     = "LRS"
  description = "Defines the type of replication to use for this storage account"
  type        = string
}

variable "default_action" {
  default     = "Deny"
  description = "The default action of allow or deny when no other rules match"
  type        = string
}

variable "delete_retention_days_policy" {
  default     = 7
  description = "The number of days that the blob should be retained, between 1 and 365 days"
  type        = number
}

variable "access_tier" {
  default     = "Hot"
  description = "The access tier for BlobStorage accounts"
  type        = string
}

variable "storage_account_network_rules_ip_rules" {
  default     = []
  description = "List of public IP or IP ranges in CIDR Format"
  type        = list(string)
}

variable "allow_nested_items_to_be_public" {
  default     = false
  description = "Allow or disallow nested items within this Account to opt into being public"
  type        = bool
}

variable "public_network_access_enabled" {
  default     = true
  description = "Whether the public network access is enabled?"
  type        = bool
}

variable "private_endpoint_subnet_id" {
  description = "Subnet resource ID of the Private endpoint subnet"
  type        = string
}

variable "private_dns_zone_ids" {
  description = "List of Private DNS Zone IDs to add to the Private DNS Zone Group of the Storage Account"
  type        = list(string)
}

variable "bastion_subnet_enforce_private_link_endpoint_network_policies" {
  default     = false
  description = "Enable or Disable network policies for the private link endpoint on the bastion subnet"
  type        = bool
}
