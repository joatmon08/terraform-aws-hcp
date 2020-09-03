data "aws_vpc_peering_connection" "hvn" {
  status      = "pending-acceptance"
  cidr_block  = var.hvn_cidr_block
  peer_vpc_id = var.vpc_id
}

resource "aws_vpc_peering_connection_accepter" "hvn" {
  vpc_peering_connection_id = data.aws_vpc_peering_connection.hvn.id
  auto_accept               = true
  tags                      = var.tags
}

resource "aws_route" "hvn" {
  for_each                  = toset(var.route_table_ids)
  route_table_id            = each.value
  destination_cidr_block    = var.hvn_cidr_block
  vpc_peering_connection_id = data.aws_vpc_peering_connection.hvn.id
}