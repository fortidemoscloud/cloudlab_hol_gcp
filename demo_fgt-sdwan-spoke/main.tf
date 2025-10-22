#------------------------------------------------------------------------------------------------------------
# Create FGT HA deployment with LoadBalancers
#------------------------------------------------------------------------------------------------------------
module "fgt-xlb" {
  source = "./modules/fgt-xlb"

  prefix = var.prefix
  region = local.custom_vars_merged["region"]
  zone1  = local.zone1
  zone2  = local.zone2

  config_spoke = true
  spoke        = local.spoke_merged
  hubs         = local.hubs

  license_type      = local.custom_vars_merged["license_type"]
  fortiflex_token_1 = var.fortiflex_token

  cluster_type = local.custom_vars_merged["fgt_cluster_type"]
  fgt_version  = replace(local.custom_vars_merged["fgt_version"], ".", "")

  spoke_vpc_cidrs = [local.custom_vars_merged["spoke_vpc_cidr"]]

  machine = local.custom_vars_merged["fgt_size"]
}
#------------------------------------------------------------------------------------------------------------
# Create VPC spokes peered to VPC FGT
#------------------------------------------------------------------------------------------------------------
module "vpc_spoke" {
  source = "./modules/vpc_spoke"

  prefix = var.prefix
  region = local.custom_vars_merged["region"]

  spoke-subnet_cidrs = [local.custom_vars_merged["spoke_vpc_cidr"]]
  fgt_vpc_self_link  = module.fgt-xlb.vpc_self_links["private"]
}
#------------------------------------------------------------------------------------------------------------
# Create VM in VPC spokes
#------------------------------------------------------------------------------------------------------------
module "vm_spoke" {
  source = "./modules/vm"

  prefix = var.prefix
  region = local.custom_vars_merged["region"]
  zone   = local.zone1

  rsa-public-key = module.fgt-xlb.public_key_openssh
  gcp-user_name  = split("@", data.google_client_openid_userinfo.me.email)[0]

  subnet_name = module.vpc_spoke.subnet_name

  machine_type = local.custom_vars_merged["k8s_size"]
  user_data    = local.k8s_user_data
}

#------------------------------------------------------------------------------------------------------------
# Secrets
#------------------------------------------------------------------------------------------------------------
# Create fgt secret
resource "google_secret_manager_secret" "fgt" {
  secret_id = "${var.prefix}-fgt"

  replication {
    automatic = true
  }
}
# Add the secret version with your value
resource "google_secret_manager_secret_version" "fgt" {
  secret      = google_secret_manager_secret.fgt.id
  secret_data = jsonencode(module.fgt-xlb.fgt_secret)
}

# Create VM secret
resource "google_secret_manager_secret" "vm" {
  secret_id = "${var.prefix}-vm"

  replication {
    automatic = true
  }
}
# Create VM secret SSH public key
resource "google_secret_manager_secret_version" "vm" {
  secret      = google_secret_manager_secret.vm.id
  secret_data = module.fgt-xlb.private_key_pem
}