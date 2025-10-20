# ----------------------------------------------------------------------------------------
# Variables
# ----------------------------------------------------------------------------------------
variable "prefix" {
  description = "Prefix to configured items in GCP"
  type        = string
  default     = "fgt-ha-xlb"
}

variable "custom_vars" {
  description = "Custom variables"
  type = object({
    region           = optional(string, "europe-southwest1")
    fgt_version      = optional(string, "7.4.7")
    license_type     = optional(string, "payg")
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
module "fgt-ha-xlb" {
  source  = "jmvigueras/ftnt-gcp-modules/gcp//examples/basic_fgt-ha-xlb"
  version = "0.0.9"

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
  cluster_type = var.custom_vars["fgt_cluster_type"]
  fgt_version  = replace(var.custom_vars["fgt_version"], ".", "")

  machine = var.custom_vars["fgt_size"]
}
#------------------------------------------------------------------------------------------------------------
# Create VPC spokes peered to VPC FGT
#------------------------------------------------------------------------------------------------------------
module "vpc_spoke" {
  source  = "jmvigueras/ftnt-gcp-modules/gcp//modules/vpc_spoke"
  version = "0.0.9"

  prefix = var.prefix
  region = var.custom_vars["region"]

  spoke-subnet_cidrs = ["172.30.100.0/23"]
  fgt_vpc_self_link  = module.fgt-ha-xlb.vpc_self_links["private"]
}
#------------------------------------------------------------------------------------------------------------
# Create VM in VPC spokes
#------------------------------------------------------------------------------------------------------------
module "vm_spoke" {
  source  = "jmvigueras/ftnt-gcp-modules/gcp//modules/vm"
  version = "0.0.9"

  prefix = var.prefix
  region = var.custom_vars["region"]
  zone   = local.zone1

  rsa-public-key = module.fgt-ha-xlb.public_key_openssh
  gcp-user_name  = split("@", data.google_client_openid_userinfo.me.email)[0]

  subnet_name = module.vpc_spoke.subnet_name

  machine_type = var.custom_vars["k8s_size"]
  user_data    = local.k8s_user_data
}

locals {
  # K8S configuration and APP deployment
  k8s_deployment = templatefile("./templates/k8s-dvwa-swagger.yaml.tp", {
    dvwa_nodeport    = "31000"
    swagger_nodeport = "31001"
    swagger_host     = module.fgt-ha-xlb.fgt["fgt_1_public"]
    swagger_url      = "http://${module.fgt-ha-xlb.fgt["fgt_1_public"]}:31001"
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
  value = module.fgt-ha-xlb.fgt
}

output "k8s" {
  value = {
    admin_user = split("@", data.google_client_openid_userinfo.me.email)[0]
    pip        = join(", ", module.vm_spoke.vm["pip"])
    ip         = join(", ", module.vm_spoke.vm["ip"])
  }
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
  backend "s3" {}
}