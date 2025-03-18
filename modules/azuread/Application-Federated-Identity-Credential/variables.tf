# -------------------------------------------------------------------------------------
#
# Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "federated_credential_abbreviation" {
  description = "Abbreviation for the Federated Identity Credential"
  type        = string
  default     = "fc"
}

variable "name" {
  description = "Name of the Federated Identity Credential"
  type        = string
}

variable "description" {
  description = "Description of the Federated Identity Credential"
  type        = string
}

variable "ad_application_id" {
  description = "The resource ID of the application for which this federated identity credential should be created."
  type        = string
}

variable "oidc_issuer_url" {
  description = "OIDC issuer url"
  type        = string
}

variable "audiences" {
  description = "Audience for the Federated Identity Credential"
  type        = list(string)
}

variable "subject" {
  description = "Subject for the Federated Identity Credential"
  type        = string
}
