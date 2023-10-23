locals {
  traffic_manager_name = join("-", ["tm", var.project, var.environment, var.location, var.padding])
}
