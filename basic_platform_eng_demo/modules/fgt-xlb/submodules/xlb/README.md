# Terraform Module: Create Forwarding Rules to Fortigates

Create forwarding rules, public and private to fortigates.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_region_backend_service.elb](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_region_backend_service) | resource |
| [google-beta_google_compute_region_backend_service.ilb](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_region_backend_service) | resource |
| [google_compute_address.elb_frontend_pip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_forwarding_rule.elb_fwd-rule_l3](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_forwarding_rule) | resource |
| [google_compute_forwarding_rule.ilb_fwd-rule_all](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_forwarding_rule) | resource |
| [google_compute_health_check.elb_health-check_fgt_global](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_health_check) | resource |
| [google_compute_instance_group.lb_group_fgt-1](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_group) | resource |
| [google_compute_instance_group.lb_group_fgt-2](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_group) | resource |
| [google_compute_region_health_check.elb_health-check_fgt](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_health_check) | resource |
| [google_compute_region_health_check.ilb_health-check_fgt](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_health_check) | resource |
| [google_compute_route.private_route_ilb_1](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_route) | resource |
| [google_compute_route.private_route_ilb_2](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_route) | resource |
| [google_compute_route.private_route_ilb_3](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_route) | resource |
| [google_compute_route.spoke_route_ilb_1](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_route) | resource |
| [google_compute_route.spoke_route_ilb_2](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_route) | resource |
| [google_compute_route.spoke_route_ilb_3](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_route) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend-probe_port"></a> [backend-probe\_port](#input\_backend-probe\_port) | Fortigate tcp port for health-checks probes from LB | `string` | `"8008"` | no |
| <a name="input_config_spoke_route"></a> [config\_spoke\_route](#input\_config\_spoke\_route) | Boolean to create routes in peered VPC to Fortigate VPC | `bool` | `false` | no |
| <a name="input_fgt_active_self_link"></a> [fgt\_active\_self\_link](#input\_fgt\_active\_self\_link) | Fortigate instance SelfLink member 1 | `string` | `null` | no |
| <a name="input_fgt_passive_self_link"></a> [fgt\_passive\_self\_link](#input\_fgt\_passive\_self\_link) | Fortigate instance SelfLink member 2 | `string` | `null` | no |
| <a name="input_ilb_ip"></a> [ilb\_ip](#input\_ilb\_ip) | Internal Load Balancer IP | `string` | `null` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | GCP resourcers prefix description | `string` | `"terraform"` | no |
| <a name="input_region"></a> [region](#input\_region) | GCP region to deploy | `string` | `"europe-west4"` | no |
| <a name="input_subnet_names"></a> [subnet\_names](#input\_subnet\_names) | Fortigate VPC private subnet names to create forwarding rules | `map(string)` | `null` | no |
| <a name="input_vpc_names"></a> [vpc\_names](#input\_vpc\_names) | Map of fortigate VPCs, used public and private | `map(string)` | `null` | no |
| <a name="input_vpc_spoke_names"></a> [vpc\_spoke\_names](#input\_vpc\_spoke\_names) | List of peered vpc names to create routes | `list(string)` | `null` | no |
| <a name="input_zone1"></a> [zone1](#input\_zone1) | GCP region Zone 1 | `string` | `"europe-west4-a"` | no |
| <a name="input_zone2"></a> [zone2](#input\_zone2) | GCP region Zone 1 | `string` | `"europe-west4-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_elb-frontend"></a> [elb-frontend](#output\_elb-frontend) | n/a |
<!-- END_TF_DOCS -->