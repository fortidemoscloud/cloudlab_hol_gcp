output "fgt_active_id" {
  description = "Fortigate instance ID member 1"
  value       = google_compute_instance.fgt-active.instance_id
}

output "fgt_active_self_link" {
  description = "Fortigate instance SelfLink member 1"
  value       = google_compute_instance.fgt-active.self_link
}

output "fgt_active_eip_mgmt" {
  description = "Fortigate instance member 1 management public IP"
  value       = google_compute_address.active-mgmt-public-ip.address
}

/*
output "fgt_active_eip_public" {
  description = "Fortigate instance member 1 public IP"
  value       = google_compute_address.active-public-ip.address
}
*/
