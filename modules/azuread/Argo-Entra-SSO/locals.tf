# -------------------------------------------------------------------------------------
#
# Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

locals {
  tier_groups = {
    "nonprod-reader"      = "Read-only access to Argo nonprod (stage) workflows across all data planes"
    "nonprod-contributor" = "Contributor (dispatch) access to Argo nonprod (stage) workflows on the control plane"
    "prod-contributor"    = "Contributor (dispatch) access to Argo prod workflows on the control plane"
    "prod-reader"         = "Read-only access to Argo prod workflows across all data planes"
  }
}
