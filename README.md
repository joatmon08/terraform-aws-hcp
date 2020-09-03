# Terraform Module for AWS and HashiCorp Cloud Platform

This module configures the following components for HCP:

- Routing tables between an AWS VPC and HVN
- Security groups to allow HashiCorp Cloud Platform (HCP) Consul on AWS

## Prerequisites

- You must have access to [HashiCorp Cloud Platform (HCP)](https://www.hashicorp.com/cloud-platform/)
- Set up a HashiCorp Virtual Network (HVN)
- Set up a HCP Consul Cluster
- A VPC that is not the same CIDR Block as HVN

## Requirements

| Name | Version |
|------|---------|
| aws | >= 3.4.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| consul\_security\_group\_ids | List of security groups IDs to allow HCP Consul connection | `list(string)` | `[]` | no |
| consul\_security\_group\_name | Name of HCP Consul security group | `string` | `"allow-hcp-consul"` | no |
| hvn\_cidr\_block | CIDR Block of HashiCorp Virtual Network | `string` | n/a | yes |
| route\_table\_ids | List of routing table IDs to route to HVN peering connection | `list(string)` | n/a | yes |
| tags | Map of tags for resources | `map(string)` | <pre>{<br>  "module": "terraform-aws-consul"<br>}</pre> | no |
| vpc\_id | The ID of your VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| hcp\_consul\_security\_group\_id | ID of security group to allow HCP Consul |
| hvn\_vpc\_peering\_connection\_id | ID of peering connection for HVN and VPC |

