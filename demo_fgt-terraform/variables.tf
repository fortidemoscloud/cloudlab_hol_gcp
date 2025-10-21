variable "fgt" {
  description = "FortiGate connection details json string (maps: api_key, fgt_1_mgmt)"
  type        = string
  default     = "{}"
}

variable "vip" {
  description = "VIP configuration json string (maps: mappedip, extport, mappedport)"
  type        = string
  default     = "{}"
}

variable "policies" {
  description = "Firewall policies configuration json string (maps: policy1)"
  type        = string
  default     = "{}"
}