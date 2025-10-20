#------------------------------------------------------------------------------------------------------------
# Provider
#------------------------------------------------------------------------------------------------------------
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.48.0"
    }
  }
  backend "s3" {}
}

provider "google" {
  region = local.custom_vars_merged["region"]
}
provider "google-beta" {
  region = local.custom_vars_merged["region"]
}

