
module "forseti" {
  source  = "terraform-google-modules/forseti/google"
  version = "~> 5.1"

  gsuite_admin_email = "[GSUITE_ADMIN_EMAIL]"
  domain             = "[DOMAIN]"
  project_id         = "[PROJECT_ID]"
  org_id             = "[ORG_ID]"
}
