# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 LLC (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "data_collection_endpoint_id" {
  description = "The ID of the Data Collection Endpoint which will be associated to the target resource"
  type        = string
}

variable "target_resource_id" {
  description = "Specifies a list of destination names"
  type        = string
}
