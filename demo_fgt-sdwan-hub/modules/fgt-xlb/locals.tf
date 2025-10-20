locals {
  #-----------------------------------------------------------------------------------------------------
  # Variables used in deployment
  #-----------------------------------------------------------------------------------------------------
  // HUB config
  hub = [for i in range(0, length(var.hub)) : merge(
    var.hub[i],
    { local_gw = module.xlb.elb-frontend }
    )
  ]

  // VPN DialUp variables
  hubs = [{
    id                = var.hub[0]["id"]
    bgp_asn           = var.hub[0]["bgp_asn_hub"]
    external_ip       = module.xlb.elb-frontend
    hub_ip            = cidrhost(var.hub[0]["vpn_cidr"], 1)
    site_ip           = ""
    hck_ip            = cidrhost(var.hub[0]["vpn_cidr"], 1)
    vpn_psk           = module.fgt_config.vpn_psk
    cidr              = var.hub[0]["cidr"]
    ike_version       = var.hub[0]["ike_version"]
    network_id        = var.hub[0]["network_id"]
    dpd_retryinterval = var.hub[0]["dpd_retryinterval"]
    sdwan_port        = var.hub[0]["vpn_port"]
  }]

}