# ----------------------------------------------------------------------------------------
# Variables
# ----------------------------------------------------------------------------------------
variable "prefix" {
  description = "Prefix to configured items in GCP"
  type        = string
  default     = "ptf-eng-demo"
}

variable "fortiflex_token" {
  description = "FortiFlex token"
  type        = string
  default     = "5247B00074EED042B601"
}

variable "custom_vars" {
  description = "Custom variables"
  type = object({
    region           = optional(string, "europe-west2")
    fgt_version      = optional(string, "7.4.7")
    license_type     = optional(string, "byol")
    fgt_size         = optional(string, "n2-standard-4")
    fgt_cluster_type = optional(string, "fgcp")
    fgt_vpc_cidr     = optional(string, "172.10.0.0/23")
    k8s_size         = optional(string, "e2-standard-2")
    k8s_version      = optional(string, "1.31")
    tags             = optional(map(string), { "Deploy" = "CloudLab GCP", "Project" = "CloudLab" })
  })
  default = {}
}

#------------------------------------------------------------------------------------------------------------
# Create FGT HA deployment with LoadBalancers
#------------------------------------------------------------------------------------------------------------
module "fgt-xlb" {
  source  = "./modules/fgt-xlb"

  project = var.project

  prefix = var.prefix
  region = var.custom_vars["region"]
  zone1  = local.zone1
  zone2  = local.zone2

  onramp = {
    id      = var.prefix
    cidr    = var.custom_vars["fgt_vpc_cidr"]
    bgp_asn = "65000"
  }

  license_type = var.custom_vars["license_type"]
  fortiflex_token_1 = var.fortiflex_token

  cluster_type = var.custom_vars["fgt_cluster_type"]
  fgt_version  = replace(var.custom_vars["fgt_version"], ".", "")

  machine = var.custom_vars["fgt_size"]
}
#------------------------------------------------------------------------------------------------------------
# Create VPC spokes peered to VPC FGT
#------------------------------------------------------------------------------------------------------------
module "vpc_spoke" {
  source  = "./modules/vpc_spoke"

  prefix = var.prefix
  region = var.custom_vars["region"]

  spoke-subnet_cidrs = ["172.30.100.0/23"]
  fgt_vpc_self_link  = module.fgt-xlb.vpc_self_links["private"]
}
#------------------------------------------------------------------------------------------------------------
# Create VM in VPC spokes
#------------------------------------------------------------------------------------------------------------
module "vm_spoke" {
  source  = "./modules/vm"

  prefix = var.prefix
  region = var.custom_vars["region"]
  zone   = local.zone1

  rsa-public-key = module.fgt-xlb.public_key_openssh
  gcp-user_name  = split("@", data.google_client_openid_userinfo.me.email)[0]

  subnet_name = module.vpc_spoke.subnet_name

  machine_type = var.custom_vars["k8s_size"]
  user_data    = local.k8s_user_data
}

locals {
  # K8S configuration and APP deployment
  k8s_deployment = templatefile("./templates/voteapp.yml.tp", {
      node_port  = "31000"
    }
  )
  k8s_user_data = templatefile("./templates/k8s.sh.tp", {
    k8s_version    = var.custom_vars["k8s_version"]
    linux_user     = split("@", data.google_client_openid_userinfo.me.email)[0]
    k8s_deployment = local.k8s_deployment
    }
  )
}
#------------------------------------------------------------------------------------------------------------
# Outputs
#------------------------------------------------------------------------------------------------------------
output "fgt" {
  value = module.fgt-xlb.fgt
}

output "k8s" {
  value = {
    admin_user = split("@", data.google_client_openid_userinfo.me.email)[0]
    pip        = join(", ", module.vm_spoke.vm["pip"])
    ip         = join(", ",module.vm_spoke.vm["ip"])
    app_url    = "http://${module.vm_spoke.vm["pip"][0]}:31000"
  }
}

# ----------------------------------------------------------------------------------------
# Data and Locals
# ----------------------------------------------------------------------------------------
data "google_compute_zones" "available_zones" {
  region = var.custom_vars["region"]
  project = var.project
}

locals {
  zone1 = length(data.google_compute_zones.available_zones.names) > 0 ? data.google_compute_zones.available_zones.names[0] : null
  zone2 = length(data.google_compute_zones.available_zones.names) > 1 ? data.google_compute_zones.available_zones.names[1] : null
}

data "google_client_openid_userinfo" "me" {}

#------------------------------------------------------------------------------------------------------------
# Provider
#------------------------------------------------------------------------------------------------------------
variable "project" {}
# Prevent Terraform warning for backend config
terraform {
  backend "s3" {}
}