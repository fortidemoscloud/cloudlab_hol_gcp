# Terraform Module: Fortigate HA

Create Fortigates instances

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_address.active-mgmt-public-ip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_address.active-public-ip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_address.passive-mgmt-public-ip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_address.passive-public-ip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_disk.active-logdisk](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_disk) | resource |
| [google_compute_disk.passive-logdisk](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_disk) | resource |
| [google_compute_instance.fgt-active](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_compute_instance.fgt-passive_fgcp](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_compute_instance.fgt-passive_fgsp](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [random_string.randon_str](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [google_compute_image.fgt_image_byol](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_image) | data source |
| [google_compute_image.fgt_image_payg](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_image) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config_fgsp"></a> [config\_fgsp](#input\_config\_fgsp) | Boolean for a Fortigate cluster type FGSP | `bool` | `false` | no |
| <a name="input_fgt-active-ni_ips"></a> [fgt-active-ni\_ips](#input\_fgt-active-ni\_ips) | Map of string with Fortigate membe 1 IPs | `map(string)` | `null` | no |
| <a name="input_fgt-passive-ni_ips"></a> [fgt-passive-ni\_ips](#input\_fgt-passive-ni\_ips) | Map of string with Fortigate membe 2 IPs | `map(string)` | `null` | no |
| <a name="input_fgt_config_1"></a> [fgt\_config\_1](#input\_fgt\_config\_1) | Bootstrap config for Fortigate 1 | `string` | `""` | no |
| <a name="input_fgt_config_2"></a> [fgt\_config\_2](#input\_fgt\_config\_2) | Bootstrap config for Fortigate 2 | `string` | `""` | no |
| <a name="input_fgt_ha_fgsp"></a> [fgt\_ha\_fgsp](#input\_fgt\_ha\_fgsp) | Boolean for a Fortigate cluster type FGSP | `bool` | `false` | no |
| <a name="input_fgt_passive"></a> [fgt\_passive](#input\_fgt\_passive) | Create Fortigate cluster member 2 | `bool` | `false` | no |
| <a name="input_fgt_version"></a> [fgt\_version](#input\_fgt\_version) | FortiOS version | `string` | `"726"` | no |
| <a name="input_gcp-user_name"></a> [gcp-user\_name](#input\_gcp-user\_name) | GCP user name that launch Terrafrom | `string` | `null` | no |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | License type for FortiGate-VM Instances, either byol or payg. | `string` | `"payg"` | no |
| <a name="input_machine"></a> [machine](#input\_machine) | GCP instance machine type | `string` | `"n1-standard-4"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | GCP resourcers prefix description | `string` | `"terraform"` | no |
| <a name="input_region"></a> [region](#input\_region) | GCP region to deploy | `string` | `"europe-west4"` | no |
| <a name="input_rsa-public-key"></a> [rsa-public-key](#input\_rsa-public-key) | SSH RSA public key | `string` | `null` | no |
| <a name="input_subnet_names"></a> [subnet\_names](#input\_subnet\_names) | Map of VPC subnets name | `map(string)` | `null` | no |
| <a name="input_zone1"></a> [zone1](#input\_zone1) | GCP region Zone 1 | `string` | `"europe-west4-a"` | no |
| <a name="input_zone2"></a> [zone2](#input\_zone2) | GCP region Zone 1 | `string` | `"europe-west4-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fgt_active_eip_mgmt"></a> [fgt\_active\_eip\_mgmt](#output\_fgt\_active\_eip\_mgmt) | Fortigate instance member 1 management public IP |
| <a name="output_fgt_active_eip_public"></a> [fgt\_active\_eip\_public](#output\_fgt\_active\_eip\_public) | Fortigate instance member 1 public IP |
| <a name="output_fgt_active_id"></a> [fgt\_active\_id](#output\_fgt\_active\_id) | Fortigate instance ID member 1 |
| <a name="output_fgt_active_self_link"></a> [fgt\_active\_self\_link](#output\_fgt\_active\_self\_link) | Fortigate instance SelfLink member 1 |
| <a name="output_fgt_passive_eip_mgmt"></a> [fgt\_passive\_eip\_mgmt](#output\_fgt\_passive\_eip\_mgmt) | Fortigate instance member 2 management public IP |
| <a name="output_fgt_passive_eip_public"></a> [fgt\_passive\_eip\_public](#output\_fgt\_passive\_eip\_public) | Fortigate instance member 2 public IP |
| <a name="output_fgt_passive_id"></a> [fgt\_passive\_id](#output\_fgt\_passive\_id) | Fortigate instance ID member 2 |
| <a name="output_fgt_passive_self_link"></a> [fgt\_passive\_self\_link](#output\_fgt\_passive\_self\_link) | Fortigate instance SelfLink member 2 |
<!-- END_TF_DOCS -->