#-----------------------------------------------------------------------------------------------------
# GCP variables
#-----------------------------------------------------------------------------------------------------
variable "project" {
  description = "GCP project"
  type        = string
  default     = null
}

variable "region" {
  description = "GCP region to deploy"
  type        = string
  default     = "europe-west2"
}

variable "zone1" {
  description = "GCP region zone 1"
  type        = string
  default     = "europe-west2-a"
}

variable "zone2" {
  description = "GCP region zone 2"
  type        = string
  default     = "europe-west2-b"
}

variable "prefix" {
  description = "GCP resources prefix description"
  type        = string
  default     = "fgt-ha-xlb"
}

#-----------------------------------------------------------------------------------------------------
# FGT variables
#-----------------------------------------------------------------------------------------------------
variable "license_type" {
  description = "Type of FortiGate license"
  type        = string
  default     = "payg"
}

variable "fortiflex_token_1" {
  description = "FortiFlex token FortiGate 1"
  type        = string
  default     = ""
}

variable "fortiflex_token_2" {
  description = "FortiFlex token FortiGate 2"
  type        = string
  default     = ""
}

variable "machine" {
  description = "Machine type for FortiGate instances"
  type        = string
  default     = "n2-standard-4"
}

variable "admin_port" {
  description = "Admin port for FortiGate instances"
  type        = string
  default     = "8443"
}

variable "admin_cidr" {
  description = "Admin CIDR to access FortiGate instances"
  type        = string
  default     = "0.0.0.0/0"
}

variable "config_spoke" {
  description = "Deploy spoke configuration"
  type        = bool
  default     = true
}

variable "spoke" {
  description = "spoke values"
  type        = map(string)
  default = {
    id      = "fgt"
    cidr    = "172.30.0.0/23"
    bgp_asn = "65000"
  }
}

variable "hubs" {
  description = "list of maps of SDWAN HUBs"
  type        = list(map(string))
  default = [
    {
      id                = "HUB"
      bgp_asn           = "65000"
      external_ip       = "11.11.11.11"
      hub_ip            = "172.20.30.1"
      site_ip           = "172.20.30.10" // set to "" if VPN mode_cfg is enable
      hck_ip            = "172.20.30.1"
      vpn_psk           = "secret"
      cidr              = "172.20.30.0/24"
      ike_version       = "2"
      network_id        = "1"
      dpd_retryinterval = "5"
      sdwan_port        = "public"
    }
  ]
}

variable "cluster_type" {
  description = "Type of FortiGates cluster"
  type        = string
  default     = "fgcp"
}

variable "fgt_version" {
  description = "FortiOS version"
  type        = string
  default     = "747"
}

variable "fgt_passive" {
  description = "Deploy or not secondary FortiGate"
  type        = bool
  default     = false
}

variable "fgt_passive" {
  description = "Deploy or not secondary FortiGate"
  type        = bool
  default     = false
}

variable "spoke_vpc_cidrs" {
  description = "List of CIDRs for spoke VPC subnets"
  type        = list(string)
  default     = null
}