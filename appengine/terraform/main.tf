## "google_app_engine_firewall_rule" is not stable.  
## Terraform State appears to base state off of the Firewall Priority and does not properly delete Firewall Rules, even when Priority is changed.
## https://github.com/terraform-providers/terraform-provider-google/issues/5681

provider "google" {
  project = var.project_id
  region  = var.region
}

variable "project_id" {
  default = "elevated-watch-270607"
}
variable "region" {
  default = "us-central1"
}

resource "google_app_engine_firewall_rule" "rule" {
  project      = var.project_id
  priority     = 1020
  action       = "DENY"
  source_range = "*"
  description  = "DENY this"
}
