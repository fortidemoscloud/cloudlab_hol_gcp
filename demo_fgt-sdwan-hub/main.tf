#------------------------------------------------------------------------------------------------------------
# Create FGT HA deployment with LoadBalancers
#------------------------------------------------------------------------------------------------------------
module "fgt-xlb" {
  source = "./modules/fgt-xlb"

  prefix = var.prefix
  region = local.custom_vars_merged["region"]
  zone1  = local.zone1
  zone2  = local.zone2

  vpc_cidr = local.custom_vars_merged["fgt_vpc_cidr"]

  config_hub = true
  hub        = local.hub_parsed

  license_type      = local.custom_vars_merged["license_type"]
  fortiflex_token_1 = var.fortiflex_token

  cluster_type = local.custom_vars_merged["fgt_cluster_type"]
  fgt_version  = replace(local.custom_vars_merged["fgt_version"], ".", "")

  machine = local.custom_vars_merged["fgt_size"]
}

# ----------------------------------------------------------------------------------------
# Data and Locals
# ----------------------------------------------------------------------------------------
data "google_compute_zones" "available_zones" {
  region = local.custom_vars_merged["region"]
}

data "google_client_openid_userinfo" "me" {}

locals {
  zone1 = length(data.google_compute_zones.available_zones.names) > 0 ? data.google_compute_zones.available_zones.names[0] : null
  zone2 = length(data.google_compute_zones.available_zones.names) > 1 ? data.google_compute_zones.available_zones.names[1] : null

  # Parse the hub variable from JSON string to a list of maps
  hub_parsed = jsondecode(var.hub)

  # Parse the custom_vars variable from JSON string to an object
  custom_vars_parsed = jsondecode(var.custom_vars)

  # Create a merged custom_vars with defaults for any missing values
  custom_vars_merged = {
    region           = try(local.custom_vars_parsed.region, "europe-west2")
    fgt_version      = try(local.custom_vars_parsed.fgt_version, "7.4.9")
    license_type     = try(local.custom_vars_parsed.license_type, "byol")
    fgt_size         = try(local.custom_vars_parsed.fgt_size, "n2-standard-4")
    fgt_cluster_type = try(local.custom_vars_parsed.fgt_cluster_type, "fgcp")
    fgt_vpc_cidr     = try(local.custom_vars_parsed.fgt_vpc_cidr, "172.10.0.0/23")
    tags             = try(local.custom_vars_parsed.tags, { "Deploy" = "CloudLab GCP", "Project" = "CloudLab" })
  }
}

#------------------------------------------------------------------------------------------------------------
# Secrets
#------------------------------------------------------------------------------------------------------------
resource "google_secret_manager_secret" "hubs" {
  secret_id = "${var.prefix}-hubs"

  replication {
    automatic = true
  }
}

# Add the secret version with your value
resource "google_secret_manager_secret_version" "hubs" {
  secret      = google_secret_manager_secret.hubs.id
  secret_data = jsonencode(module.fgt-xlb.hubs)
}

#------------------------------------------------------------------------------------------------------------
# Outputs
#------------------------------------------------------------------------------------------------------------
output "fgt" {
  value = module.fgt-xlb.fgt
}

output "hubs_secret_id" {
  value = "${var.prefix}-hubs"
}