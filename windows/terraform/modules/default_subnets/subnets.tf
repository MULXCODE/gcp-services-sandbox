data "google_compute_network" "default" {
  name = var.network_name
}

locals {
  subnets = {
    "subnet1" = {
      subnet_name               = "supersubnet",
      subnet_ip                 = "172.16.0.0/20",
      subnet_region             = "us-west1",
      subnet_private_access     = "true",
      subnet_flow_logs          = true,
      subnet_flow_logs_interval = "INTERVAL_5_SEC",
      subnet_flow_logs_sampling = "0.5",
      network_name              = "default",
      project                   = var.project_id
    }
  }
  
  secondary_ranges = {
    "supersubnet" = [
      {
        range_name    = "supersubnet-01"
        ip_cidr_range = "192.168.64.0/24"
      },
      {
        range_name    = "supersubnet-02"
        ip_cidr_range = "192.168.65.0/24"
      },
    ]
  }
}
resource "google_compute_subnetwork" "subnetwork" {
  for_each                 = local.subnets
  name                     = each.value.subnet_name
  ip_cidr_range            = each.value.subnet_ip
  region                   = each.value.subnet_region
  private_ip_google_access = lookup(each.value, "subnet_private_access", "false")
  dynamic "log_config" {
    for_each = lookup(each.value, "subnet_flow_logs", false) ? [{
      aggregation_interval = lookup(each.value, "subnet_flow_logs_interval", "INTERVAL_5_SEC")
      flow_sampling        = lookup(each.value, "subnet_flow_logs_sampling", "0.5")
      metadata             = lookup(each.value, "subnet_flow_logs_metadata", "INCLUDE_ALL_METADATA")
    }] : []
    content {
      aggregation_interval = log_config.value.aggregation_interval
      flow_sampling        = log_config.value.flow_sampling
      metadata             = log_config.value.metadata
    }
  }
  network     = each.value.network_name
  project     = var.project_id
  description = lookup(each.value, "description", null)
  secondary_ip_range = [
    for i in range(
      length(
        contains(
        keys(local.secondary_ranges), each.value.subnet_name) == true
        ? local.secondary_ranges[each.value.subnet_name]
        : []
    )) :
    local.secondary_ranges[each.value.subnet_name][i]
  ]
}
