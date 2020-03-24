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

