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

variable "fgt_active_self_link" {
  description = "Fortigate instance SelfLink member 1"
  type        = string
  default     = null
}

variable "fgt_passive_self_link" {
  description = "Fortigate instance SelfLink member 2"
  type        = string
  default     = null
}

variable "backend-probe_port" {
  description = "Fortigate tcp port for health-checks probes from LB"
  type        = string
  default     = "8008"
}

variable "ilb_ip" {
  description = "Internal Load Balancer IP"
  type        = string
  default     = null
}

variable "config_spoke_route" {
  description = "Boolean to create routes in peered VPC to Fortigate VPC"
  type        = bool
  default     = false
}

variable "vpc_spoke_names" {
  description = "List of peered vpc names to create routes"
  type        = list(string)
  default     = null
}

variable "subnet_names" {
  description = "Fortigate VPC private subnet names to create forwarding rules"
  type        = map(string)
  default     = null
}

variable "vpc_names" {
  description = "Map of fortigate VPCs, used public and private"
  type        = map(string)
  default     = null
}

