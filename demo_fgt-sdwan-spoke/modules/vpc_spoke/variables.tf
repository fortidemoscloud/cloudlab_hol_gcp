variable "prefix" {
  description = "GCP resourcers prefix description"
  type        = string
  default     = "terraform"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "europe-west4"
}

variable "spoke-subnet_cidrs" {
  description = "List of CIDRs to create peered VPC to FGT VPC"
  type        = list(string)
  default     = []
}

variable "fgt_vpc_self_link" {
  description = "FGT VPC SelfLink to create peer"
  type        = string
  default     = null
}
