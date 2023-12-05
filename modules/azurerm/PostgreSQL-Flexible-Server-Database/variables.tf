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

variable "database_name" {
  description = "Name of the PostgreSQL Database"
  type        = string
}

variable "server_id" {
  description = "ID of the PostgreSQL Server"
  type        = string
}

variable "charset" {
  default     = "utf8"
  description = "Specifies the Charset for the PostgreSQL Database"
  type        = string
}

variable "collation" {
  default     = "en_US.utf8"
  description = "Specifies the Collation for the PostgreSQL Database"
  type        = string
}
