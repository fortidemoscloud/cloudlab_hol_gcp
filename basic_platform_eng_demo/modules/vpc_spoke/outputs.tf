output "vpc_name" {
  description = "Peered VPC name"
  value       = google_compute_network.vpc_spoke.*.name
}

output "subnet_name" {
  description = "Subnet name in VPC"
  value       = google_compute_subnetwork.subnet_spoke.*.name
}

output "fwr_tag" {
  description = "Firewall rules tags"
  value       = google_compute_firewall.vpc_spoke_fw_allow-all.*.target_tags
}