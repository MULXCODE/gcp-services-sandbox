provider "google" {
  project = var.project_id
}

module "default_firewall_rules" {
  source = "./modules/default_firewall_rules"

  network_name = "default"
  source_range = "0.0.0.0/0"
}

module "default_routes" {
  source = "./modules/default_routes"

  network_name = "default"
}

module "default_subnets" {
  source = "./modules/default_subnets"

  project_id   = var.project_id
  network_name = "default"
}



module "windows_instance" {
    source = "./modules/instance"
    zone = "us-west1-a"
    network_tags = ["allow-rdp", "allow-winrm", "allow-ad"]
    service_account_email = "sandbox-0700@appspot.gserviceaccount.com"
}

