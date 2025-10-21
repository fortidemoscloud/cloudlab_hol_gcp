# ------------------------------------------------------------------------------------------
# Terraform state
# ------------------------------------------------------------------------------------------
terraform {
  required_version = ">= 0.12"
  required_providers {
    fortios = {
      source = "fortinetdev/fortios"
    }
  }
}
# ------------------------------------------------------------------------------------------
# FortiOS provider
# ------------------------------------------------------------------------------------------
provider "fortios" {
  hostname = local.fgt_merged.fgt_1_mgmt
  token    = local.fgt_merged.api_key
  insecure = "true"
}