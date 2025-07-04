# -------------------------------------------------------------------------------------
#
# Copyright (c) 2025, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
#
# WSO2 LLC. licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the
# specific language governing permissions and limitations
# under the License.
#
# --------------------------------------------------------------------------------------

resource "time_rotating" "time_rotating_1" {
  rotation_months = var.secret1_rotation_time_in_months
}

resource "time_rotating" "time_rotating_2" {
  rfc3339         = time_rotating.time_rotating_1.rotation_rfc3339
  rotation_months = var.secret2_rotation_offset_in_months

  lifecycle {
    ignore_changes = [rfc3339]
  }
}

resource "azuread_application_password" "application_password_1" {
  application_id = var.application_object_id
  display_name   = "${var.display_name}-${time_rotating.time_rotating_1.rotation_rfc3339}-1"
  end_date       = timeadd(time_rotating.time_rotating_1.rotation_rfc3339, "720h")

  rotate_when_changed = {
    rotation = time_rotating.time_rotating_1.id
  }
  lifecycle {
    ignore_changes = [end_date]
  }
}

resource "azuread_application_password" "application_password_2" {
  application_id = var.application_object_id
  display_name   = "${var.display_name}-${time_rotating.time_rotating_2.rotation_rfc3339}-2"
  end_date       = timeadd(time_rotating.time_rotating_2.rotation_rfc3339, "720h")

  rotate_when_changed = {
    rotation = time_rotating.time_rotating_2.id
  }
  lifecycle {
    ignore_changes = [end_date]
  }
}
