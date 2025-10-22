#------------------------------------------------------------------------------------------------------------
# Outputs
#------------------------------------------------------------------------------------------------------------
output "fgt" {
  value = module.fgt-xlb.fgt
}

output "fgt_secret_id" {
  value = "${var.prefix}-fgt"
}

output "vm" {
  value = {
    admin_user = split("@", data.google_client_openid_userinfo.me.email)[0]
    pip        = join(", ", module.vm_spoke.vm["pip"])
    ip         = join(", ", module.vm_spoke.vm["ip"])
    app_url    = "http://${module.vm_spoke.vm["pip"][0]}:31000"
  }
}

output "vm_secret_id" {
  value = "${var.prefix}-vm"
}