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

variable "project_id" {}
variable "project" {}
variable "service_endpoint_name" {}
variable "description" {}
variable "apiserver_url" {}
variable "admin_kube_config" {}
variable "cluster_context" {}
variable "accept_untrusted_certs" {
  default = "false"
}
