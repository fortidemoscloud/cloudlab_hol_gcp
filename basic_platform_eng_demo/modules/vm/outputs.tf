output "vm" {
  description = "Map of VM instance details"
  value = {
    pip       = google_compute_address.instance_pip.*.address
    ip        = google_compute_instance.instance.*.network_interface.0.network_ip
    self_link = google_compute_instance.instance.*.self_link
  }
}