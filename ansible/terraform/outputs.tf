// output "instances" {
//     value = google_compute_instance.default[*]
// }

// output "instance_zones" {
//     value = google_compute_instance.default[*].zone
// }

// output "instance_names" {
//     value = google_compute_instance.default.*.name
// }

// output "network_ips" {
//     value = google_compute_instance.default.*.network_interface[*][0].network_ip
// }

output "nat_ips" {
    value = google_compute_instance.default.*.network_interface[*][0].access_config[0].nat_ip
}
// output "subnetworks" {
//     value = google_compute_instance.default.*.network_interface[*][0].subnetwork
// }
