# Terraform Module: Linux VM

Create a Linux VM instance wihin GCP

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
| [google_compute_address.instance_pip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_instance.instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gcp-user_name"></a> [gcp-user\_name](#input\_gcp-user\_name) | GCP user name launch Terrafrom | `string` | `null` | no |
| <a name="input_image-vm"></a> [image-vm](#input\_image-vm) | VM test Image name | `string` | `"debian-cloud/debian-11"` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | GCP instance machine type for testing vm | `string` | `"e2-small"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | GCP resourcers prefix description | `string` | `"terraform"` | no |
| <a name="input_region"></a> [region](#input\_region) | GCP region | `string` | `"europe-west4"` | no |
| <a name="input_rsa-public-key"></a> [rsa-public-key](#input\_rsa-public-key) | SSH RSA public key | `string` | `null` | no |
| <a name="input_ssh-keys"></a> [ssh-keys](#input\_ssh-keys) | SSH RSA public key for KeyPair if not exists | `string` | `null` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | List of subnet to create vm | `list(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | List of tag to add | `list(string)` | <pre>[<br>  "tag-default"<br>]</pre> | no |
| <a name="input_zone"></a> [zone](#input\_zone) | GCP region zone 1 | `string` | `"europe-west4-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vm"></a> [vm](#output\_vm) | Map of VM instance details |
<!-- END_TF_DOCS -->