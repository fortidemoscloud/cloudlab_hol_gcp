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

variable "vpc_cidr" {
  description = "VPC CIDR for FortiGate deployment"
  type        = string
  default     = "10.0.0.0/23"
}

variable "config_hub" {
  description = "Configure FortiGate as SD-WAN Hub"
  type        = bool
  default     = true
}

variable "hub" {
  description = "SD-WAN Hub configuration"
  type = list(object({
    id                = optional(string, "HUB")
    bgp_asn_hub       = optional(string, "65000")
    bgp_asn_spoke     = optional(string, "65000")
    vpn_cidr          = string
    vpn_psk           = optional(string, "")
    cidr              = string
    ike_version       = optional(string, "2")
    network_id        = optional(string, "1")
    dpd_retryinterval = optional(string, "10")
    vpn_port          = optional(string, "public")
    local_gw          = optional(string, "")
  }))
}