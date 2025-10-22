# Terraform Module: Create peered VPC to Fortigate private VPC

Create peerd VPC to fortigate private VPC wihin GCP

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_firewall.vpc_spoke_fw_allow-all](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_network.vpc_spoke](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_network_peering.vpc_spoke_peer-to-private_1](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network_peering) | resource |
| [google_compute_network_peering.vpc_spoke_peer-to-private_2](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network_peering) | resource |
| [google_compute_subnetwork.subnet_spoke](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_fgt_vpc_self_link"></a> [fgt\_vpc\_self\_link](#input\_fgt\_vpc\_self\_link) | FGT VPC SelfLink to create peer | `string` | `null` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | GCP resourcers prefix description | `string` | `"terraform"` | no |
| <a name="input_region"></a> [region](#input\_region) | GCP region | `string` | `"europe-west4"` | no |
| <a name="input_spoke-subnet_cidrs"></a> [spoke-subnet\_cidrs](#input\_spoke-subnet\_cidrs) | List of CIDRs to create peered VPC to FGT VPC | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fwr_tag"></a> [fwr\_tag](#output\_fwr\_tag) | Firewall rules tags |
| <a name="output_subnet_name"></a> [subnet\_name](#output\_subnet\_name) | Subnet name in VPC |
| <a name="output_vpc_name"></a> [vpc\_name](#output\_vpc\_name) | Peered VPC name |
<!-- END_TF_DOCS -->