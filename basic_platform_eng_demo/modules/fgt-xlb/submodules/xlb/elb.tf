#---------------------------------------------------------------------
# Create https load balancing to vm spokes as backend
# - Create public IP
# - Create health checks
# - Create forwarding rule L3 to backend
# - Create backend to FGT instances
#---------------------------------------------------------------------
# ELB Frontends
resource "google_compute_address" "elb_frontend_pip" {
  name         = "${var.prefix}-elb-frontend-pip"
  region       = var.region
  address_type = "EXTERNAL"
}

# Create health checks (regional)
resource "google_compute_region_health_check" "elb_health-check_fgt" {
  name               = "${var.prefix}-elb-fgt-health-check"
  region             = var.region
  check_interval_sec = 5
  timeout_sec        = 1

  tcp_health_check {
    port = var.backend-probe_port
  }
}

# Create External Load Balancer
resource "google_compute_region_backend_service" "elb" {
  provider = google-beta
  name     = "${var.prefix}-elb"
  region   = var.region

  load_balancing_scheme = "EXTERNAL"
  protocol              = "UNSPECIFIED"

  backend {
    group          = google_compute_instance_group.lb_group_fgt-1.id
    balancing_mode = "CONNECTION"
  }

  health_checks = [google_compute_region_health_check.elb_health-check_fgt.id]
  connection_tracking_policy {
    connection_persistence_on_unhealthy_backends = "NEVER_PERSIST"
  }
}

## ELB Frontend forwarding rule - NetworkLoadBalancer
resource "google_compute_forwarding_rule" "elb_fwd-rule_l3" {
  name   = "${var.prefix}-elb-fwd-rule-l3"
  region = var.region

  load_balancing_scheme = "EXTERNAL"
  ip_protocol           = "L3_DEFAULT"
  all_ports             = true
  backend_service       = google_compute_region_backend_service.elb.id
  ip_address            = google_compute_address.elb_frontend_pip.id
}

# Create health checks (global)
resource "google_compute_health_check" "elb_health-check_fgt_global" {
  name               = "${var.prefix}-elb-fgt-health-check-global"
  check_interval_sec = 5
  timeout_sec        = 1

  tcp_health_check {
    port = var.backend-probe_port
  }
}