# HCP Boundary self-managed worker

This module sets up an HCP Boundary self-mangaed worker. It requires
Vault in order to register the worker's token into a key-value path.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.15.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam"></a> [iam](#module\_iam) | ../iam | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_instance.worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_9202_worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_egress_worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_boundary_cluster_id"></a> [boundary\_cluster\_id](#input\_boundary\_cluster\_id) | HCP Boundary Cluster ID | `string` | n/a | yes |
| <a name="input_key_pair_name"></a> [key\_pair\_name](#input\_key\_pair\_name) | AWS Key pair for SSH access | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of worker and associated resources | `string` | n/a | yes |
| <a name="input_public_subnet_id"></a> [public\_subnet\_id](#input\_public\_subnet\_id) | Public Subnet ID for instance | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for associated resources | `map(string)` | `{}` | no |
| <a name="input_vault_addr"></a> [vault\_addr](#input\_vault\_addr) | Vault address for worker to write authentication token | `string` | `null` | no |
| <a name="input_vault_namespace"></a> [vault\_namespace](#input\_vault\_namespace) | Vault namespace for worker to write authentication token. For ENT or HCP | `string` | `"admin"` | no |
| <a name="input_vault_path"></a> [vault\_path](#input\_vault\_path) | Vault path for worker to write authentication token | `string` | `"/boundary"` | no |
| <a name="input_vault_token"></a> [vault\_token](#input\_vault\_token) | Vault token for worker to write authentication token | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID for security group | `string` | n/a | yes |
| <a name="input_worker_security_group_id"></a> [worker\_security\_group\_id](#input\_worker\_security\_group\_id) | Boundary worker security group ID. If null, module will create it | `string` | `null` | no |
| <a name="input_worker_tags"></a> [worker\_tags](#input\_worker\_tags) | A list of worker tags for filtering in Boundary | `list(string)` | `[]` | no |
| <a name="input_worker_upstreams"></a> [worker\_upstreams](#input\_worker\_upstreams) | A list of workers to connect to upstream. For multi-hop worker sessions. Format should be ["<upstream\_worker\_public\_addr>:9202"] | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | Security group for worker |
| <a name="output_worker"></a> [worker](#output\_worker) | Information about Boundary worker |
