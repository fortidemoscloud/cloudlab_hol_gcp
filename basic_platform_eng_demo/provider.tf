### GCP terraform for HA setup
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.48.0"
    }
  }
}
provider "google" {
  region = var.custom_vars["region"]
}
provider "google-beta" {
  region = var.custom_vars["region"]
}

