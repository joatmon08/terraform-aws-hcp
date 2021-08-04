# Terraform Module for AWS and HashiCorp Cloud Platform

This module configures the following components for HCP:

- HashiCorp Virtual Network (HVN)
- Routing tables and peering connection between an AWS VPC and HVN
- (Optional) HashiCorp Cloud Platform (HCP) Consul cluster (development tier)
- (Optional) Security groups rules to allow HCP Consul on AWS
- (Optional) HashiCorp Cloud Platform (HCP) Vault cluster (development tier)

## Prerequisites

You must have access to [HashiCorp Cloud Platform (HCP)](https://www.hashicorp.com/cloud-platform/).
Create an HCP [service principal](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/guides/auth)
before using the [HCP Provider for Terraform](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs).
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.52 |
| <a name="requirement_hcp"></a> [hcp](#requirement\_hcp) | >= 0.11 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.52.0 |
| <a name="provider_hcp"></a> [hcp](#provider\_hcp) | 0.11.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route.hvn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_security_group_rule.hcp_consul](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_vpc_peering_connection_accepter.hvn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_accepter) | resource |
| [hcp_aws_network_peering.peer](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/aws_network_peering) | resource |
| [hcp_consul_cluster.consul](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/consul_cluster) | resource |
| [hcp_hvn.hvn](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/hvn) | resource |
| [hcp_hvn_route.hvn](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/hvn_route) | resource |
| [hcp_vault_cluster.vault](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hcp_consul_datacenter"></a> [hcp\_consul\_datacenter](#input\_hcp\_consul\_datacenter) | Datacenter for HCP Consul cluster. If undefined, uses `hcp_consul_name`. | `string` | `null` | no |
| <a name="input_hcp_consul_name"></a> [hcp\_consul\_name](#input\_hcp\_consul\_name) | Name for HCP Consul cluster. If left as an empty string, a cluster will not be created. | `string` | `""` | no |
| <a name="input_hcp_consul_public_endpoint"></a> [hcp\_consul\_public\_endpoint](#input\_hcp\_consul\_public\_endpoint) | Enable public endpoint for HCP Consul cluster. | `bool` | `false` | no |
| <a name="input_hcp_consul_security_group_ids"></a> [hcp\_consul\_security\_group\_ids](#input\_hcp\_consul\_security\_group\_ids) | Security Group IDs to allow HCP Consul. | `list(string)` | `[]` | no |
| <a name="input_hcp_consul_tier"></a> [hcp\_consul\_tier](#input\_hcp\_consul\_tier) | Tier for HCP Consul cluster. Must be `development` or `standard`. | `string` | `"development"` | no |
| <a name="input_hcp_consul_version"></a> [hcp\_consul\_version](#input\_hcp\_consul\_version) | Minimum Consul version. Defaults to HCP recommendation. | `string` | `null` | no |
| <a name="input_hcp_vault_name"></a> [hcp\_vault\_name](#input\_hcp\_vault\_name) | Name for HCP Vault cluster. If left as an empty string, a cluster will not be created. | `string` | `""` | no |
| <a name="input_hcp_vault_public_endpoint"></a> [hcp\_vault\_public\_endpoint](#input\_hcp\_vault\_public\_endpoint) | Enable public endpoint for HCP Vault cluster. | `bool` | `false` | no |
| <a name="input_hvn_cidr_block"></a> [hvn\_cidr\_block](#input\_hvn\_cidr\_block) | CIDR Block of HashiCorp Virtual Network. Cannot overlap with `vpc_cidr_block`. | `string` | n/a | yes |
| <a name="input_hvn_name"></a> [hvn\_name](#input\_hvn\_name) | Name of HashiCorp Virtual Network. | `string` | n/a | yes |
| <a name="input_hvn_region"></a> [hvn\_region](#input\_hvn\_region) | AWS region for HashiCorp Virtual Network. | `string` | n/a | yes |
| <a name="input_number_of_route_table_ids"></a> [number\_of\_route\_table\_ids](#input\_number\_of\_route\_table\_ids) | Number of routing table ids. Works around GH-4149. | `number` | n/a | yes |
| <a name="input_route_table_ids"></a> [route\_table\_ids](#input\_route\_table\_ids) | List of routing table IDs to route to HVN peering connection. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags for resources | `map(string)` | <pre>{<br>  "module": "terraform-aws-hcp"<br>}</pre> | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR Block of VPC. Cannot overlap with `hvn_cidr_block`. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of VPC. | `string` | n/a | yes |
| <a name="input_vpc_owner_id"></a> [vpc\_owner\_id](#input\_vpc\_owner\_id) | Owner ID of VPC. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hcp_consul_id"></a> [hcp\_consul\_id](#output\_hcp\_consul\_id) | ID of HCP Consul. |
| <a name="output_hcp_consul_private_endpoint"></a> [hcp\_consul\_private\_endpoint](#output\_hcp\_consul\_private\_endpoint) | Private endpoint of HCP Consul. |
| <a name="output_hcp_consul_public_endpoint"></a> [hcp\_consul\_public\_endpoint](#output\_hcp\_consul\_public\_endpoint) | Private endpoint of HCP Consul. |
| <a name="output_hcp_vault_id"></a> [hcp\_vault\_id](#output\_hcp\_vault\_id) | ID of HCP Vault. |
| <a name="output_hcp_vault_private_endpoint"></a> [hcp\_vault\_private\_endpoint](#output\_hcp\_vault\_private\_endpoint) | Private endpoint of HCP Vault. |
| <a name="output_hcp_vault_public_endpoint"></a> [hcp\_vault\_public\_endpoint](#output\_hcp\_vault\_public\_endpoint) | Private endpoint of HCP Vault. |
| <a name="output_hvn_id"></a> [hvn\_id](#output\_hvn\_id) | ID of HashiCorp Virtual Network. |
