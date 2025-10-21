# ------------------------------------------------------------------------------------------
# Data and Locals
# ------------------------------------------------------------------------------------------
locals {
  # Parse the custom_vars variable from JSON string to an object
  fgt_data = var.fgt_secret_id != "" ? data.google_secret_manager_secret_version.fgt_secret.secret_data : var.fgt != "" ? var.fgt : "{}"
  fgt = jsondecode(local.fgt_data)

  # Create a merged FortiGate maps
  fgt_merged = {
    api_key    = try(local.fgt.api_key, "")
    fgt_1_mgmt = try(local.fgt.fgt_1_mgmt, "")
  }

  # Create a merged VIP maps
  vip = jsondecode(var.vip)
  vip_merged = { for k, v in local.vip : k => 
    {
      mappedip   = try(v.mappedip, "")
      extport    = try(v.extport, "80")
      mappedport = try(v.mappedport, "80")
    } if try(v.mappedip, "") != ""
  }

  fgt_port1_secondary_ip = split(" ", data.fortios_system_interface.port1.secondaryip[0].ip)[0]
}

# Get port1 internal IP address
data "fortios_system_interface" "port1" {
  name = "port1"
}

data "google_secret_manager_secret_version" "fgt_secret" {
  secret = var.fgt_secret_id
}

# ------------------------------------------------------------------------------------------
# Outputs
# ------------------------------------------------------------------------------------------
output "vip_firewall_policy" {
  value = { for k, v in fortios_firewall_policy.firewall_policy : k => {
      firewall_policy = v.name
    }
  }
}

output "vips" {
  value = local.vip_merged
}

# ------------------------------------------------------------------------------------------
# Create VIP and firewal policy
# ------------------------------------------------------------------------------------------
# Create VIP
resource "fortios_firewall_vip" "vip" {
  for_each = local.vip_merged

  name = "vip-${local.fgt_port1_secondary_ip}-${each.value.extport}"

  type        = "static-nat"
  extintf     = "port1"
  extip       = local.fgt_port1_secondary_ip
  extport     = each.value.extport
  mappedport  = each.value.mappedport
  portforward = "enable"

  mappedip {
    range = "${each.value.mappedip}-${each.value.mappedip}"
  }
}
# Define a new firewall policy with default intrusion prevention profile
resource "fortios_firewall_policy" "firewall_policy" {
  depends_on = [fortios_firewall_vip.vip]

  for_each = local.vip_merged

  name = "vip-${local.fgt_port1_secondary_ip}-${each.value.extport}"

  schedule        = "always"
  action          = "accept"
  utm_status      = "enable"
  ips_sensor      = "all_default_pass"
  ssl_ssh_profile = "certificate-inspection"
  nat             = "enable"
  logtraffic      = "all"

  dstintf {
    name = "port2"
  }
  srcintf {
    name = "port1"
  }
  srcaddr {
    name = "all"
  }
  dstaddr {
    name = "vip-${local.fgt_port1_secondary_ip}-${each.value.extport}"
  }
  service {
    name = "ALL"
  }
}