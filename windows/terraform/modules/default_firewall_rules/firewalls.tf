data "google_compute_network" "default" {
  name = var.network_name
}

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = data.google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "8080"]
  }

  source_ranges = [var.source_range]
  target_tags   = ["allow-http"]
}

resource "google_compute_firewall" "allow_icmp" {
  name    = "allow-icmp"
  network = data.google_compute_network.default.name

  allow {
    protocol = "icmp"
  }

  source_ranges = [var.source_range]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = data.google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [var.source_range]
  target_tags   = ["allow-ssh"]
}

resource "google_compute_firewall" "allow_rdp" {
  name    = "allow-rdp"
  network = data.google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = [var.source_range]
  target_tags   = ["allow-rdp"]
}

resource "google_compute_firewall" "allow_winrm" {
  name    = "allow-winrm"
  network = data.google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["5985", "5986"]
  }

  source_ranges = [var.source_range]
  target_tags   = ["allow-winrm"]
}

resource "google_compute_firewall" "allow_ad" {
  name    = "allow-ad"
  network = data.google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["53", "88", "135", "389", "445", "636", "3268", "3269"]
  }

  allow {
    protocol = "udp"
    ports    = ["53", "88", "389", "445"]
  }

  source_ranges = [var.source_range]
  target_tags   = ["allow-ad"]
}


### DBs

resource "google_compute_firewall" "allow_sqlserver" {
  name    = "allow-sqlserver"
  network = data.google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["1433", "1434"]
  }

  source_ranges = [var.source_range]
  target_tags   = ["allow-sqlserver"]
}

resource "google_compute_firewall" "allow_mysql" {
  name    = "allow-mysql"
  network = data.google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["3306"]
  }

  source_ranges = [var.source_range]
  target_tags   = ["allow-mysql"]
}

resource "google_compute_firewall" "allow_postgres" {
  name    = "allow-postgres"
  network = data.google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }

  source_ranges = [var.source_range]
  target_tags   = ["allow-postgres"]
}

### GCP Specific Firewall Rules

resource "google_compute_firewall" "allow_iap" {
  name    = "allow-iap"
  network = data.google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
}

resource "google_compute_firewall" "allow_health_checks" {
  name    = "allow-health-checks"
  network = data.google_compute_network.default.name

  allow {
    protocol = "tcp"
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16", "209.85.152.0/22", "209.85.204.0/22"]
  target_tags   = ["allow-health-checks"]
}

resource "google_compute_firewall" "allow_internal" {
  name    = "allow-internal"
  network = data.google_compute_network.default.name

  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports = ["0-65535"]
  }

  source_ranges = ["10.128.0.0/9"]
}

