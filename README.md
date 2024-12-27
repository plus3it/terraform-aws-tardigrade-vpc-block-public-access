# terraform-aws-tardigrade-vpc-block-public-access
Terraform module to manage settings for AWS VPC Block Public Access

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.79.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.79.0 |

## Resources

| Name | Type |
|------|------|

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vpc_block_public_access"></a> [vpc\_block\_public\_access](#input\_vpc\_block\_public\_access) | VPC block public access settings | <pre>object({<br>    internet_gateway_block_mode = string<br><br>    exclusions = optional(list(object({<br>      name                            = string<br>      internet_gateway_exclusion_mode = string<br><br>      subnet_id = optional(string)<br>      vpc_id    = optional(string)<br>      tags      = optional(map(string), {})<br>    })), [])<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_exclusions"></a> [exclusions](#output\_exclusions) | Map of VPC block public access exclusion objects |
| <a name="output_options"></a> [options](#output\_options) | VPC block public access options |

<!-- END TFDOCS -->
