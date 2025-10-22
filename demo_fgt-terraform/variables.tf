variable "fgt" {
  description = "FortiGate connection details json string (maps: api_key, fgt_1_mgmt)"
  type        = string
  default     = ""
}

variable "fgt_secret_id" {
  description = "GCP Secret Manager value of FortiGate connection details json string"
  type        = string
  default     = ""
}

variable "vips" {
  description = "VIP configuration json string (maps: mappedip, extport, mappedport)"
  type        = string
  default     = "{}"
}

variable "policies" {
  description = "Firewall policies configuration json string (maps: policy1)"
  type        = string
  default     = "{}"
}

variable "region" {
  description = "GCP region to deploy resources"
  type        = string
  default     = "europe-west2"
}