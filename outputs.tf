output "hvn_vpc_peering_connection_id" {
  value = data.aws_vpc_peering_connection.hvn.id
  description = "ID of peering connection for HVN and VPC"
}

output "hcp_consul_security_group_id" {
  value       = aws_security_group.allow_hcp_consul.0.id
  description = "ID of security group to allow HCP Consul"
}