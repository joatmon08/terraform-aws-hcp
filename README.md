# Terraform Module for AWS and HashiCorp Cloud Platform

This module configures the following components for HCP:

- HashiCorp Virtual Network (HVN)
- Routing tables and peering connection between an AWS VPC and HVN
- (Optional) HashiCorp Cloud Platform (HCP) Consul cluster
- (Optional) Security groups rules to allow HCP Consul on AWS

## Prerequisites

You must have access to [HashiCorp Cloud Platform (HCP)](https://www.hashicorp.com/cloud-platform/).
Create an HCP [service principal](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/guides/auth)
before using the [HCP Provider for Terraform](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs).

## Requirements

| Name | Version |
|------|---------|
| terraform | >=0.14 |
| aws | >= 3.34 |
| hcp | >= 0.3 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.34 |
| hcp | >= 0.3 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| hcp\_consul\_datacenter | Datacenter for HCP Consul cluster. If undefined, uses `hcp_consul_name`. | `string` | `null` | no |
| hcp\_consul\_name | Name for HCP Consul cluster. If left as an empty string, a cluster will not be created. | `string` | `""` | no |
| hcp\_consul\_public\_endpoint | Enable public endpoint for HCP Consul cluster. | `bool` | `false` | no |
| hcp\_consul\_security\_group\_ids | Security Group IDs to allow HCP Consul. | `list(string)` | `[]` | no |
| hcp\_consul\_tier | Tier for HCP Consul cluster. Must be `development` or `standard`. | `string` | `"development"` | no |
| hvn\_cidr\_block | CIDR Block of HashiCorp Virtual Network. Cannot overlap with `vpc_cidr_block`. | `string` | n/a | yes |
| hvn\_name | Name of HashiCorp Virtual Network. | `string` | n/a | yes |
| hvn\_region | AWS region for HashiCorp Virtual Network. | `string` | n/a | yes |
| number\_of\_route\_table\_ids | Number of routing table ids. Works around GH-4149. | `number` | n/a | yes |
| route\_table\_ids | List of routing table IDs to route to HVN peering connection. | `list(string)` | n/a | yes |
| tags | Map of tags for resources | `map(string)` | <pre>{<br>  "module": "terraform-aws-hcp"<br>}</pre> | no |
| vpc\_cidr\_block | CIDR Block of VPC. Cannot overlap with `hvn_cidr_block`. | `string` | n/a | yes |
| vpc\_id | ID of VPC. | `string` | n/a | yes |
| vpc\_owner\_id | Owner ID of VPC. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| hcp\_cluster\_id | ID of HCP Consul cluster. |
| hvn\_id | ID of HashiCorp Virtual Network. |

