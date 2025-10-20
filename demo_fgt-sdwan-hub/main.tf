#------------------------------------------------------------------------------------------------------------
# Create FGT HA deployment with LoadBalancers
#------------------------------------------------------------------------------------------------------------
module "fgt-xlb" {
  source = "./modules/fgt-xlb"

  prefix = var.prefix
  region = var.custom_vars["region"]
  zone1  = local.zone1
  zone2  = local.zone2

  vpc_cidr = var.custom_vars["fgt_vpc_cidr"]

  config_hub = true
  hub        = var.hub

  license_type      = var.custom_vars["license_type"]
  fortiflex_token_1 = var.fortiflex_token

  cluster_type = var.custom_vars["fgt_cluster_type"]
  fgt_version  = replace(var.custom_vars["fgt_version"], ".", "")

  machine = var.custom_vars["fgt_size"]
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