#------------------------------------------------------------------------------------------------------------
# Outputs
#------------------------------------------------------------------------------------------------------------
output "fgt" {
  value = module.fgt-xlb.fgt
}

output "hubs_secret_id" {
  value = "${var.prefix}-hubs"
}

#------------------------------------------------------------------------------------------------------------
# Secrets
#------------------------------------------------------------------------------------------------------------
resource "google_secret_manager_secret" "hubs" {
  secret_id = "${var.prefix}-hubs"

  replication {
    automatic = true
  }
}

# Add the secret version with your value
resource "google_secret_manager_secret_version" "hubs" {
  secret      = google_secret_manager_secret.hubs.id
  secret_data = jsonencode(module.fgt-xlb.hubs)
}