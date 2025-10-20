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
  description = "Custom variables as JSON string"
  type        = string
  default     = "{}"
}

variable "hub" {
  description = "SDWAN HUB values as JSON string"
  type        = string
  default     = "[{}]"
}
