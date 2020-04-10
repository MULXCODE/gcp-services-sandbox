include {
  path = find_in_parent_folders()
}

locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  
  location = local.common_vars.inputs.location
}

terraform {
  source = "../../terraform/gcs-bucket"
}

inputs = {
  location = local.location
}
