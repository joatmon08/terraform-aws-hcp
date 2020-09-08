output "hvn_vpc_peering_connection_id" {
  value       = data.aws_vpc_peering_connection.hvn.id
  description = "ID of peering connection for HVN and VPC"
}
