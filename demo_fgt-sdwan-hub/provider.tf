#------------------------------------------------------------------------------------------------------------
# Provider
#------------------------------------------------------------------------------------------------------------
terraform {
  backend "s3" {}
}
provider "google" {
  region = local.custom_vars_merged["region"]
}
provider "google-beta" {
  region = local.custom_vars_merged["region"]
}

