variable "location" {
  default = "EU"
}

resource "random_id" "server" {
  byte_length = 2 
}

resource "google_storage_bucket" "static-site" {
  name          = "image-store-${random_id.server.hex}"
  location      = var.location 
  force_destroy = true

  bucket_policy_only = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
  cors {
    origin          = ["http://image-store.com"]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}

