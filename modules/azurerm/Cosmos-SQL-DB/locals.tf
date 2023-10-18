locals {
  autoscale_setting = var.is_autoscaled == false ? toset([]): toset([var.throughput])
}
