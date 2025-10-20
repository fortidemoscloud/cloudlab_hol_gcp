#------------------------------------------------------------------------------------------------------------
# Create FGT HA deployment with LoadBalancers
#------------------------------------------------------------------------------------------------------------
data "google_secret_manager_secret_version" "hubs_secret" {
  secret = var.hubs_secret_id
}

locals {
  hubs = var.hubs_secret_id != "" ? jsondecode(data.google_secret_manager_secret_version.hubs_secret.secret_data) : var.hubs != null ? var.hubs : [{}]
  spoke = {
    id      = var.spoke["id"]
    bgp_asn = lookup(local.hubs[0], "bgp_asn", "65000")
    cidr    = var.spoke["cidr"]
  }
}

#------------------------------------------------------------------------------------------------------------
# Create FGT HA deployment with LoadBalancers
#------------------------------------------------------------------------------------------------------------
module "fgt-xlb" {
  source = "./modules/fgt-xlb"

  prefix = var.prefix
  region = var.custom_vars["region"]
  zone1  = local.zone1
  zone2  = local.zone2

  config_spoke = true
  spoke        = local.spoke
  hubs         = local.hubs

  license_type      = var.custom_vars["license_type"]
  fortiflex_token_1 = var.fortiflex_token

  cluster_type = var.custom_vars["fgt_cluster_type"]
  fgt_version  = replace(var.custom_vars["fgt_version"], ".", "")

  machine = var.custom_vars["fgt_size"]
}

#------------------------------------------------------------------------------------------------------------
# Outputs
#------------------------------------------------------------------------------------------------------------
output "fgt" {
  value = module.fgt-xlb.fgt
}

# ----------------------------------------------------------------------------------------
# Data and Locals
# ----------------------------------------------------------------------------------------
data "google_compute_zones" "available_zones" {
  region = var.custom_vars["region"]
}

locals {
  zone1 = length(data.google_compute_zones.available_zones.names) > 0 ? data.google_compute_zones.available_zones.names[0] : null
  zone2 = length(data.google_compute_zones.available_zones.names) > 1 ? data.google_compute_zones.available_zones.names[1] : null
}

data "google_client_openid_userinfo" "me" {}

#------------------------------------------------------------------------------------------------------------
# Provider
#------------------------------------------------------------------------------------------------------------
# Prevent Terraform warning for backend config
terraform {
  #backend "s3" {}
}