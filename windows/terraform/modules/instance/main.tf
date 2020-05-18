variable "zone" {}
variable "network_tags" {
  type = list(string)
}
variable "service_account_email" {}

resource "random_id" "random_project_id_suffix" {
  byte_length = 2
}

resource "google_compute_instance" "default" {
  name         = format("%s-%s", "windows", random_id.random_project_id_suffix.hex)
  machine_type = "n2-standard-4"
  zone         = var.zone

  tags = var.network_tags

  boot_disk {
    initialize_params {
      image = "windows-cloud/windows-2019"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    windows-startup-script-ps1 = file("./modules/instance/files/startup.ps1")
  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
    email  = var.service_account_email
  }
}
