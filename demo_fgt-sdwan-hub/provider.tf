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
  #backend "s3" {}
}
provider "google" {
  project = var.project
  region  = var.custom_vars["region"]
}
provider "google-beta" {
  project = var.project
  region  = var.custom_vars["region"]
}

