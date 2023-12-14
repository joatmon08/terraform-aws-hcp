# HCP Boundary self-managed worker

This module sets up an HCP Boundary self-mangaed worker.

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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.boundary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.boundary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_instance.worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_9202_worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_egress_worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_boundary_addr"></a> [boundary\_addr](#input\_boundary\_addr) | Boundary address. | `string` | n/a | yes |
| <a name="input_boundary_password"></a> [boundary\_password](#input\_boundary\_password) | Boundary password. Set because of `terraform test`. | `string` | n/a | yes |
| <a name="input_boundary_scope_id"></a> [boundary\_scope\_id](#input\_boundary\_scope\_id) | Boundary scope ID for worker, defaults to global | `string` | `"global"` | no |
| <a name="input_boundary_username"></a> [boundary\_username](#input\_boundary\_username) | Boundary username. Set because of `terraform test`. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of worker and associated resources | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for associated resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID for security group | `string` | n/a | yes |
| <a name="input_worker_instance_type"></a> [worker\_instance\_type](#input\_worker\_instance\_type) | Boundary worker instance type | `string` | `"t3.micro"` | no |
| <a name="input_worker_keypair_name"></a> [worker\_keypair\_name](#input\_worker\_keypair\_name) | AWS Key pair for SSH access | `string` | n/a | yes |
| <a name="input_worker_prefix"></a> [worker\_prefix](#input\_worker\_prefix) | Optional worker prefix for naming workers | `string` | `""` | no |
| <a name="input_worker_public_subnet_id"></a> [worker\_public\_subnet\_id](#input\_worker\_public\_subnet\_id) | Public Subnet ID for instance | `string` | n/a | yes |
| <a name="input_worker_security_group_id"></a> [worker\_security\_group\_id](#input\_worker\_security\_group\_id) | Boundary worker security group ID. If null, module will create it | `string` | `null` | no |
| <a name="input_worker_tags"></a> [worker\_tags](#input\_worker\_tags) | A list of worker tags for filtering in Boundary. | `list(string)` | <pre>[<br>  "ingress"<br>]</pre> | no |
| <a name="input_worker_upstreams"></a> [worker\_upstreams](#input\_worker\_upstreams) | A list of workers to connect to upstream. For multi-hop worker sessions. Format should be ["<upstream\_worker\_public\_addr>:9202"] | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | Security group for worker |
| <a name="output_worker"></a> [worker](#output\_worker) | EC2 instance information about Boundary worker |
