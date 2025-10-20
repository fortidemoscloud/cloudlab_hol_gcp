variable "prefix" {
  description = "Prefix to configured items in GCP"
  type        = string
  default     = "ptf-eng-demo"
}

variable "fortiflex_token" {
  description = "FortiFlex token"
  type        = string
  default     = ""
}

variable "custom_vars" {
  description = "Custom variables"
  type = object({
    region           = optional(string, "europe-west2")
    fgt_version      = optional(string, "7.4.8d")
    license_type     = optional(string, "byol")
    fgt_size         = optional(string, "n2-standard-4")
    fgt_cluster_type = optional(string, "fgcp")
    fgt_vpc_cidr     = optional(string, "172.10.0.0/23")
    tags             = optional(map(string), { "Deploy" = "CloudLab GCP", "Project" = "CloudLab" })
  })
  default = {}
}

variable "spoke" {
  description = "SDWAN spoke values"
  type        = map(string)
  default     = {}
}

variable "hubs" {
  description = "SDWAN HUBs values"
  type        = list(map(string))
  default     = null
}

variable "hubs_secret_id" {
  description = "SDWAN HUBs values"
  type        = string
  default     = ""
}