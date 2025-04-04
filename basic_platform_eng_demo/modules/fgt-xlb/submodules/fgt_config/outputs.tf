output "fgt_config_1" {
  description = "Fortigate 1 bootstrap config"
  value       = data.template_file.fgt_active.rendered
}

output "fgt_config_2" {
  description = "Fortigate 2 bootstrap config"
  value       = data.template_file.fgt_passive.rendered
}

output "vpn_psk" {
  description = "IPSEC VPN PreShared Key"
  value       = var.hub[0]["vpn_psk"] == "" ? random_string.vpn_psk.result : var.hub[0]["vpn_psk"]
}

output "api_key" {
  description = "Fortigates API keys"
  value       = var.api_key == null ? random_string.api_key.result : var.api_key
}

output "fgsp_auto-config_secret" {
  description = "Fortigate auto-scale protocol secret password"
  value       = random_string.fgsp_auto-config_secret.result
}


