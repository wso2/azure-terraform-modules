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

variable "server_configuration_name" {
  description = "Name of the PostgreSQL Server Configuration"
  type        = string
}

variable "sever_configuration_value" {
  description = "Value of the PostgreSQL Server Configuration"
  type        = string
}

variable "postgresql_flexible_server_id" {
  description = "ID of the PostgreSQL Server"
  type        = string
}
