#------------------------------------------------------------------------------------------------------------
# Create VPCs and subnets Fortigate
# - VPC for MGMT and HA interface
# - VPC for Public interface
# - VPC for Private interface  
#------------------------------------------------------------------------------------------------------------
module "fgt_vpc" {
  source = "./submodules/vpc_fgt"

  region = var.region
  prefix = var.prefix

  vpc-sec_cidr = var.spoke["cidr"]
}

#------------------------------------------------------------------------------------------------------------
# Create FGT cluster config
#------------------------------------------------------------------------------------------------------------
module "fgt_config" {
  source = "./submodules/fgt_config"

  admin_cidr     = var.admin_cidr
  admin_port     = var.admin_port
  rsa-public-key = trimspace(tls_private_key.ssh-rsa.public_key_openssh)

  subnet_cidrs       = module.fgt_vpc.subnet_cidrs
  fgt-active-ni_ips  = module.fgt_vpc.fgt-active-ni_ips
  fgt-passive-ni_ips = module.fgt_vpc.fgt-passive-ni_ips

  config_fgcp = var.cluster_type == "fgcp" ? true : false
  config_fgsp = var.cluster_type == "fgsp" ? true : false

  license_type      = var.license_type
  fortiflex_token_1 = var.fortiflex_token_1
  fortiflex_token_2 = var.fortiflex_token_2

  config_spoke = var.config_spoke
  spoke        = var.spoke
  hubs         = var.hubs

  config_xlb = true
  ilb_ip     = module.fgt_vpc.ilb_ip

  vpc-spoke_cidr = [module.fgt_vpc.subnet_cidrs["bastion"]]
}
#------------------------------------------------------------------------------------------------------------
# Create FGT cluster instances
#------------------------------------------------------------------------------------------------------------
module "fgt" {
  source = "./submodules/fgt"

  prefix = var.prefix
  region = var.region
  zone1  = var.zone1
  zone2  = var.zone2

  machine        = var.machine
  rsa-public-key = trimspace(tls_private_key.ssh-rsa.public_key_openssh)
  gcp-user_name  = split("@", data.google_client_openid_userinfo.me.email)[0]
  license_type   = var.license_type

  subnet_names      = module.fgt_vpc.subnet_names
  fgt-active-ni_ips = module.fgt_vpc.fgt-active-ni_ips

  fgt_config_1 = module.fgt_config.fgt_config_1

  config_fgsp = var.cluster_type == "fgsp" ? true : false

  fgt_version = var.fgt_version
}
#------------------------------------------------------------------------------------------------------------
# Create Internal and External Load Balancer
#------------------------------------------------------------------------------------------------------------
module "xlb" {
  source = "./submodules/xlb"

  prefix = var.prefix
  region = var.region
  zone1  = var.zone1
  zone2  = var.zone2

  vpc_names            = module.fgt_vpc.vpc_names
  subnet_names         = module.fgt_vpc.subnet_names
  ilb_ip               = module.fgt_vpc.ilb_ip
  fgt_active_self_link = module.fgt.fgt_active_self_link
}


#------------------------------------------------------------------------------------------------------------
# Necessary variables
#------------------------------------------------------------------------------------------------------------
data "google_client_openid_userinfo" "me" {}

resource "tls_private_key" "ssh-rsa" {
  algorithm = "RSA"
}

resource "local_file" "ssh_private_key_pem" {
  content         = tls_private_key.ssh-rsa.private_key_pem
  filename        = ".ssh/${var.prefix}-ssh-key.pem"
  file_permission = "0600"
}