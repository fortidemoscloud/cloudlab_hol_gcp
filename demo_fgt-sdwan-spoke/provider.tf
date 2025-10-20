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
  project = var.project
  region  = var.custom_vars["region"]
}
provider "google-beta" {
  project = var.project
  region  = var.custom_vars["region"]
}

