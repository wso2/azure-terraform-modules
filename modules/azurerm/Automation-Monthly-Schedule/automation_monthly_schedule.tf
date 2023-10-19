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

resource "azurerm_automation_schedule" "automation_monthly_schedule" {
  name                    = var.automation_monthly_schedule_name
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  frequency               = var.automation_monthly_schedule_frequency
  interval                = var.automation_monthly_schedule_intervel
  timezone                = var.automation_monthly_schedule_timezone
  start_time              = var.automation_monthly_schedule_start_time
  description             = var.automation_monthly_schedule_description
  month_days              = var.automation_monthly_schedule_days
}
