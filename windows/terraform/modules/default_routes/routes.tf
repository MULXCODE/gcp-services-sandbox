data "google_compute_network" "default" {
  name = var.network_name
}

resource "google_compute_route" "route-ilb" {
  name        = "route-internet-gateway"
  dest_range  = "0.0.0.0/0"
  description = "Default route to the internet"
  network     = data.google_compute_network.default.name
  priority    = 1000

  next_hop_gateway = "global/gateways/default-internet-gateway"
}

# resource "google_compute_route" "subnetwork-route" {
#   name         = "route-us-central1"
#   dest_range   = "10.184.0.0/20"
#   description = "Route to subnetwork 10.182.0.0/20."
#   network      = data.google_compute_network.default.name
#   priority     = 1000

#   # next_hop_ip = "10.128.0.1"
#   # next_hop_vpn_tunnel      = data.google_compute_network.default.name
#   # next_hop_instance = data.google_compute_network.default.self_link
#   # next_hop_instance_zone = "us-west1-a"
# }
