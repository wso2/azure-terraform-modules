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

variable "length" {
  description = "The length of the generated password"
  type        = number
  default     = 20
}

variable "include_special_characters" {
  description = "Whether to include special characters in the generated password"
  type        = bool
  default     = 20
}

variable "override_special_characters" {
  description = "Override the default special characters with a custom set"
  type        = string
  default     = "_+.~^#*?"
}

variable "min_numeric" {
  description = "The minimum number of numeric characters in the generated password"
  type        = number
  default     = 1
}

variable "min_upper" {
  description = "The minimum number of uppercase characters in the generated password"
  type        = number
  default     = 1
}

variable "min_lower" {
  description = "The minimum number of lowercase characters in the generated password"
  type        = number
  default     = 1
}

variable "min_special" {
  description = "The minimum number of special characters in the generated password"
  type        = number
  default     = 1
}

variable "keepers" {
  description = "Arbitrary map of values that, when changed, will trigger recreation of resource"
  type        = map(string)
  default     = {}
}
