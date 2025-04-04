output "fgt" {
  value = {
    fgt_1_mgmt   = "https://${module.fgt.fgt_active_eip_mgmt}:${var.admin_port}"
    fgt_1_pass   = module.fgt.fgt_active_id
    fgt_1_public = module.fgt.fgt_active_eip_public
    api_key      = module.fgt_config.api_key
    vpn_psk      = module.fgt_config.vpn_psk
  }
}

output "vpc_self_links" {
  value = module.fgt_vpc.vpc_self_links
}

output "vpc_ids" {
  value = module.fgt_vpc.vpc_ids
}

output "subnet_cidrs" {
  value = module.fgt_vpc.subnet_cidrs
}

output "subnet_names" {
  value = module.fgt_vpc.subnet_names
}

output "subnet_ids" {
  value = module.fgt_vpc.subnet_ids
}

output "public_key_openssh" {
  value = trimspace(tls_private_key.ssh-rsa.public_key_openssh)
}