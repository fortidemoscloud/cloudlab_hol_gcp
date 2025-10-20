variable "prefix" {
  description = "GCP resourcers prefix description"
  type        = string
  default     = "terraform"
}

variable "region" {
  description = "GCP region to deploy"
  type        = string
  default     = "europe-west4" #Default Region
}

variable "zone1" {
  description = "GCP region Zone 1"
  type        = string
  default     = "europe-west4-a" #Default Zone
}

variable "zone2" {
  description = "GCP region Zone 1"
  type        = string
  default     = "europe-west4-a" #Default Zone
}

variable "machine" {
  description = "GCP instance machine type"
  type        = string
  default     = "n1-standard-4"
}

variable "license_type" {
  description = "License type for FortiGate-VM Instances, either byol or payg."
  type        = string
  default     = "payg"
}

/*
variable "license_file_1" {
  description = "Path to your own byol license file, license1.lic"
  type    = string
  default = "./licenses/license1.lic"
}

variable "license_file_2" {
  description = "Path to your own byol license file, license2.lic"
  type    = string
  default = "./licenses/license2.lic"
}
*/

variable "fgt_version" {
  description = "FortiOS version"
  type        = string
  default     = "728"
}

variable "fgt_passive" {
  description = "Create Fortigate cluster member 2"
  type        = bool
  default     = false
}

variable "fgt_ha_fgsp" {
  description = "Boolean for a Fortigate cluster type FGSP"
  type        = bool
  default     = false
}

variable "fgt_config_1" {
  description = "Bootstrap config for Fortigate 1"
  type        = string
  default     = ""
}

variable "fgt_config_2" {
  description = "Bootstrap config for Fortigate 2"
  type        = string
  default     = ""
}

variable "rsa-public-key" {
  description = "SSH RSA public key"
  type        = string
  default     = null
}

variable "gcp-user_name" {
  description = "GCP user name that launch Terrafrom"
  type        = string
  default     = null
}

variable "fgt-active-ni_ips" {
  description = "Map of string with Fortigate membe 1 IPs"
  type        = map(string)
  default     = null
}

variable "fgt-passive-ni_ips" {
  description = "Map of string with Fortigate membe 2 IPs"
  type        = map(string)
  default     = null
}

variable "subnet_names" {
  description = "Map of VPC subnets name"
  type        = map(string)
  default     = null
}

variable "config_fgsp" {
  description = "Boolean for a Fortigate cluster type FGSP"
  type        = bool
  default     = false
}