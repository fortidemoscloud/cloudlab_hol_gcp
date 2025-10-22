# ----------------------------------------------------------------------------------------
# Data and Locals
# ----------------------------------------------------------------------------------------
data "google_compute_zones" "available_zones" {
  region = local.custom_vars_merged["region"]
}

locals {
  zone1 = length(data.google_compute_zones.available_zones.names) > 0 ? data.google_compute_zones.available_zones.names[0] : null
  zone2 = length(data.google_compute_zones.available_zones.names) > 1 ? data.google_compute_zones.available_zones.names[1] : null

  # Parse the hubs variable from JSON string to a list of maps
  hubs = var.hubs_secret_id != "" ? jsondecode(data.google_secret_manager_secret_version.hubs_secret.secret_data) : var.hubs != null ? var.hubs : [{}]

  # Parse the spoke variable from JSON string to a map
  spoke_parsed = jsondecode(var.spoke)
  spoke_merged = {
    id      = try(local.spoke_parsed.id, "spoke1")
    bgp_asn = try(local.spoke_parsed.bgp_asn, lookup(local.hubs[0], "bgp_asn", "65000"))
    cidr    = try(local.spoke_parsed.cidr, "172.10.1.0/24")
  }

  # Parse the custom_vars variable from JSON string to an object
  custom_vars_parsed = jsondecode(local.custom_vars_merged)

  # Create a merged custom_vars with defaults for any missing values
  custom_vars_merged = {
    region           = try(local.custom_vars_parsed.region, "europe-west2")
    fgt_version      = try(local.custom_vars_parsed.fgt_version, "7.4.9")
    license_type     = try(local.custom_vars_parsed.license_type, "byol")
    fgt_size         = try(local.custom_vars_parsed.fgt_size, "n2-standard-4")
    fgt_cluster_type = try(local.custom_vars_parsed.fgt_cluster_type, "fgcp")
    fgt_vpc_cidr     = try(local.custom_vars_parsed.fgt_vpc_cidr, "172.10.0.0/23")
    spoke_vpc_cidr   = try(local.custom_vars_parsed.spoke_vpc_cidr, "172.10.100.0/23")
    k8s_size         = try(local.custom_vars_parsed.k8s_size, "e2-standard-2")
    k8s_version      = try(local.custom_vars_parsed.k8s_version, "1.31")
    tags             = try(local.custom_vars_parsed.tags, { "Deploy" = "CloudLab GCP", "Project" = "CloudLab" })
  }

  # K8S configuration and APP deployment
  k8s_deployment = templatefile("./templates/voteapp.yml.tp", {
    node_port = "31000"
    }
  )
  k8s_user_data = templatefile("./templates/k8s.sh.tp", {
    k8s_version    = local.custom_vars_merged["k8s_version"]
    linux_user     = split("@", data.google_client_openid_userinfo.me.email)[0]
    k8s_deployment = local.k8s_deployment
    }
  )
}

data "google_client_openid_userinfo" "me" {}

data "google_secret_manager_secret_version" "hubs_secret" {
  secret = var.hubs_secret_id
}