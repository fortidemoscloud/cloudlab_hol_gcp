variable "prefix" {
  description = "GCP resourcers prefix description"
  type        = string
  default     = "terraform"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "europe-west4" #Default Region
}

variable "zone" {
  description = "GCP region zone 1"
  type        = string
  default     = "europe-west4-a"
}

variable "subnet_name" {
  description = "List of subnet to create vm"
  type        = list(string)
  default     = null
}

variable "image-vm" {
  description = "VM test Image name"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2204-lts"
}

variable "ssh-keys" {
  description = "SSH RSA public key for KeyPair if not exists"
  type        = string
  default     = null
}

variable "machine_type" {
  description = "GCP instance machine type for testing vm"
  type        = string
  default     = "e2-small"
}

variable "rsa-public-key" {
  description = "SSH RSA public key"
  type        = string
  default     = null
}

variable "gcp-user_name" {
  description = "GCP user name launch Terrafrom"
  type        = string
  default     = null
}

variable "tags" {
  description = "List of tag to add"
  type        = list(string)
  default     = ["tag-default"]
}

variable "user_data" {
  description = "VM custom data"
  type        = string
  default     = null
}