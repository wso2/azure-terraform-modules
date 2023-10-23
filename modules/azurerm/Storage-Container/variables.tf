variable "container_name" {}
variable "storage_account_name" {}

variable "container_access_type" {
  description = "Access type of the container"
  default     = "private"
}
